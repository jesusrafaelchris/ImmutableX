import UIKit
import ImmutableXWalletSDK
import ImmutableXCore

class LoginViewController: UIViewController {

    //var glaip: Glaip?
    
    let loginToMetamaskButton: UIButton = {
        let button = UIButton()
        button.translatesAutoresizingMaskIntoConstraints = false
        button.backgroundColor = .red
        button.setTitle("login", for: .normal)
        button.addTarget(self, action: #selector(loginToMetamask), for: .touchUpInside)
        return button
    }()

    override func viewDidLoad() {
        super.viewDidLoad()
//        self.glaip = Glaip(
//          title: "Glaip Demo App",
//          description: "Demo app to demonstrate Web3 login",
//          supportedWallets: [.MetaMask])
        setupView()
    }
    
    func setupView() {
        view.addSubview(loginToMetamaskButton)
        
        loginToMetamaskButton.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        loginToMetamaskButton.centerYAnchor.constraint(equalTo: view.centerYAnchor).isActive = true
    }
    
    @objc func loginToMetamask() async {
//        glaip?.loginUser(type: .MetaMask) { result in
//          switch result {
//          case .success(let user):
//            print(user.wallet.address)
//          case .failure(let error):
//            print(error)
//          }
//        }
        
        do {
            try await ImmutableXWallet.shared.connect(
                to: .walletConnect(
                    config: .init(
                        appURL: URL(string: "https://immutable.com")!,
                        appName: "ImmutableX Sample",
                        // The Universal Link or URL Scheme of the chosen wallet to be connected.
                        walletDeeplink: "https://metamask.app.link"
                    )
                )
            )
        } catch {
            print(error)
        }
    }
}
