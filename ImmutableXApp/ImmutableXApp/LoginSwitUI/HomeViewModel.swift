import Foundation
import ImmutableXCore
import ImmutableXWalletSDK

struct ConnectedState {
    let ethAddress: String
    let starkAddress: String
}

enum HomeState {
    case connected(ConnectedState)
    case disconnected
    case disconnecting
    case connecting
}

@MainActor
final class HomeViewModel: ObservableObject {
    private static let callbackId = "Home"

    @Published var state: HomeState = .disconnected
    @Published var errorAlert: ImmutableXWalletError?
    @Published var cryptoUrl: String?
    @Published var isLoading: Bool = false

    private let wallet: ImmutableXWallet = .shared
    private let core: ImmutableX = .shared

    init() {
        // ImmutableXWallet is an actor and requires an async context
        Task {
            await wallet.setStatusCallbackForId(HomeViewModel.callbackId) { [weak self] status in
                await self?.updateStatus(status)
            }
        }
    }

    func buyCryptoButtonTapped() async {
        do {
            defer {
                isLoading = false
            }
            isLoading = true
            let signer = try await wallet.signer.orThrowIfNil()
            cryptoUrl = try await core.buyCryptoURL(signer: signer)
        } catch {
            print("buy crypto error: \(error)")
            errorAlert = error as? ImmutableXWalletError
        }
    }

    func connectButtonTapped() async {
        do {
            try await wallet.connect(
                to: .walletConnect(
                    config: .init(
                        appURL: URL(string: "https://immutable.com")!,
                        appName: "ImmutableX Sample",
                        // The Universal Link or URL Scheme of the chosen wallet to be connected.
                        //
                        // - Note: using the standard Wallet Connect `wc://` URL Scheme will automatically try to open
                        // the latest downloaded app that registers this scheme (but note that it may not work with
                        // all Wallet Connect compatible wallets!).
                        //
                        // For example, if a user has Metamask and Rainbow wallets installed, and Metamask was installed
                        // after Rainbow, iOS will pick Metamask as the owner of that URL Scheme.
                        //
                        // This is an iOS behaviour and cannot be changed. Alternatively, the developer might offer a
                        // list of Wallet Connect compatible wallets
                        // (https://explorer.walletconnect.com/?type=wallet&version=1&chains=eip155%3A1) for the user
                        // to choose from.
                        //
                        // Wallet Connect also provides an API for registered Wallets
                        // (https://docs.walletconnect.com/2.0/introduction/cloud-explorer#cloud-explorer-api)
                        // (https://explorer-api.walletconnect.com/v1/wallets?entries=1000&page=1&version=1) that can
                        // be used to build a wallet picker.
                        //
                        // Some examples of wallets' Universal Links:
                        // - https://link.trustwallet.com
                        // - https://rnbwapp.com
                        // - https://metamask.app.link
                        //
                        // Use "wc://" if testing on simulator with the wallet server example app from
                        // https://github.com/WalletConnect/WalletConnectSwift-Example
                        walletDeeplink: "https://metamask.app.link"
                    )
                )
            )

            guard let signer = await wallet.signer, let starkSigner = await wallet.starkSigner else {
                throw AppError.nullValue
            }

            try await core.registerOffchain(signer: signer, starkSigner: starkSigner)
        } catch {
            print("Connect error: \(error)")
            errorAlert = error as? ImmutableXWalletError
        }
    }

    func disconnectButtonTapped() async {
        try? await wallet.disconnect()
    }

    func cancelConnectionButtonTapped() async {
        state = .disconnected
    }

    private func updateStatus(_ status: ImmutableXWalletStatus) async {
        switch status {
        case .connecting:
            state = .connecting
        case .connected:
            async let ethAddress = wallet.getWalletAddress()
            async let starkAddress = wallet.starkSigner?.getAddress()

            do {
                try await state = .connected(
                    .init(ethAddress: ethAddress ?? "null", starkAddress: starkAddress ?? "null")
                )
            } catch {
                errorAlert = error as? ImmutableXWalletError
            }
        case .disconnecting:
            state = .disconnecting
        case .disconnected:
            state = .disconnected
        case .pendingConnection, .pendingSignature:
            break
        }
    }
}
