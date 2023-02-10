import SwiftUI

struct HomeView: View {
    @ObservedObject private var viewModel: HomeViewModel

    private var isErrorAlertPresented: Binding<Bool> {
        Binding<Bool>(
            get: { viewModel.errorAlert != nil },
            set: { _ in viewModel.errorAlert = nil }
        )
    }

    private var isCryptoUrlPresented: Binding<Bool> {
        Binding<Bool>(
            get: { viewModel.cryptoUrl != nil },
            set: { _ in viewModel.cryptoUrl = nil }
        )
    }

    init(viewModel: HomeViewModel) {
        self.viewModel = viewModel
    }

    var body: some View {
        NavigationView {
            ZStack {

                stateView
                    .opacity(viewModel.isLoading ? 0.1 : 1.0)

                if viewModel.isLoading {
                    ProgressView("Loading Moonpay...")
                }
            }
            .alert(
                "Something went wrong",
                isPresented: isErrorAlertPresented,
                actions: {
                    Button("OK") {}
                }, message: {
                    switch viewModel.errorAlert {
                    case .couldNotLaunchWallet:
                        #if targetEnvironment(simulator)
                            // https://github.com/WalletConnect/WalletConnectSwift-Example
                            Text(
                                """
                                No WalletConnect compatible wallet app found in the Simulator.

                                You may download the Example Server app from Wallet Connect Github for simulator
                                testing or use a physical device with a wallet app installed.
                                """
                            )
                        #else
                            Text("No WalletConnect compatible wallet app found")
                        #endif
                    default:
                        Text(String(describing: viewModel.errorAlert))
                    }
                }
            )
            .padding(24)
            .navigationTitle("IMX Sample")
        }
    }

    @ViewBuilder private var stateView: some View {
        switch viewModel.state {
        case .disconnected:
            Button("Connect wallet", action: {
                Task {
                    await viewModel.connectButtonTapped()
                }
            })
        case .disconnecting:
            ProgressView("Disconnecting...")
        case .connecting:
            connectingView
        case let .connected(state):
            connectedView(with: state)
        }
    }

    private var connectingView: some View {
        ProgressView {
            VStack {
                Text("Connecting...")
                Spacer().frame(height: 48)
                Button("Cancel", action: {
                    Task {
                        await viewModel.cancelConnectionButtonTapped()
                    }
                })
            }
        }
    }

    private func connectedView(with state: ConnectedState) -> some View {
        VStack(spacing: 24) {
            VStack {
                Text("Wallet address").bold()
                Text(state.ethAddress)
            }
            .onTapGesture {
                UIPasteboard.general.string = state.ethAddress
            }

            VStack {
                Text("Stark address").bold()
                Text(state.starkAddress)
            }
            .onTapGesture {
                UIPasteboard.general.string = state.starkAddress
            }

            Spacer().frame(height: 16)

            Button("Disconnect wallet", action: {
                Task {
                    await viewModel.disconnectButtonTapped()
                }
            })

            Spacer().frame(height: 16)

            NavigationLink("Buy Assets") {
                //BuyView(viewModel: .init())
            }
            NavigationLink("My Assets") {
                //SellView(viewModel: .init())
            }
            Button("Buy Crypto", action: {
                Task {
                    await viewModel.buyCryptoButtonTapped()
                }
            })

            Spacer()
        }
    }
}

struct HomeView_Previews: PreviewProvider {
    static var previews: some View {
        let viewModel = HomeViewModel()
        viewModel.state = .disconnected
        return HomeView(viewModel: viewModel)
    }
}
