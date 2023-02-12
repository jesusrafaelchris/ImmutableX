import UIKit

class HomeViewController: UIViewController {
    
    lazy var topBarView: TopBarView = {
        let topBarView = TopBarView()
        return topBarView
    }()
    
    lazy var logoImage: UIImageView = {
        let imageView = UIImageView()
        imageView.image = UIImage(named: "Logo")
        imageView.contentMode = .scaleAspectFill
        imageView.layer.masksToBounds = true
        imageView.layer.cornerRadius = 0
        return imageView
    }()

    
    lazy var playView: PlayView = {
        let view = PlayView()
        view.isUserInteractionEnabled = true
        return view
    }()
    
    lazy var assetView: AssetView = {
        let view = AssetView()
        view.isUserInteractionEnabled = true
        return view
    }()
    
    lazy var marketView: MarketView = {
        let view = MarketView()
        view.isUserInteractionEnabled = true
        return view
    }()
    
    lazy var buttons: GrayButtonsView = {
        let button = GrayButtonsView()
        return button
    }()
    
    @objc func didtapbox4() {
        
        DispatchQueue.main.async {
            let vc = MarketplaceViewController()
            self.navigationController?.present(vc, animated: true)
        }
    }
    
    @objc func didtapbox3() {
        
        DispatchQueue.main.async {
            let vc = GameViewController()
            self.navigationController?.pushViewController(vc, animated: true)
        }
    }
    
    @objc func didtapbox2() {
        
        DispatchQueue.main.async {
            let vc = AssetViewController()
            self.navigationController?.present(vc, animated: true)
        }
    }
    
    @objc func didtapbox() {
        
        DispatchQueue.main.async {
            let vc = ProfileViewController()
            self.navigationController?.present(vc, animated: true)
        }
    }
    
    private lazy var backgroundImageView: UIImageView = {
        let imageView = UIImageView(image: UIImage(named: "Background"))
        imageView.contentMode = .scaleAspectFill
        imageView.translatesAutoresizingMaskIntoConstraints = false
        return imageView
    }()

    override func viewDidLoad() {
        super.viewDidLoad()
        marketView.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(didtapbox4)))
        playView.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(didtapbox3)))
        assetView.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(didtapbox2)))
        buttons.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(didtapbox)))
        setUpView()
        view.backgroundColor = .white
        //HttpManager.shared.mintNFT()
    }
    func setUpView(){
        
        view.addSubview(backgroundImageView)
        view.addSubview(topBarView)
        view.addSubview(logoImage)
        view.addSubview(playView)
        view.addSubview(marketView)
        view.addSubview(assetView)
        view.addSubview(buttons)
        
        backgroundImageView.topAnchor.constraint(equalTo: view.topAnchor).isActive = true
        backgroundImageView.bottomAnchor.constraint(equalTo: view.bottomAnchor).isActive = true
        backgroundImageView.leftAnchor.constraint(equalTo: view.leftAnchor).isActive = true
        backgroundImageView.rightAnchor.constraint(equalTo: view.rightAnchor).isActive = true

        topBarView.anchor(top: view.topAnchor, paddingTop: 70, bottom: nil, paddingBottom: 0, left: view.leftAnchor, paddingLeft: 32, right: view.rightAnchor, paddingRight: 16, width: 0, height: 0)
        
        logoImage.anchor(top: topBarView.topAnchor, paddingTop: 80, bottom: nil, paddingBottom: 0, left: nil, paddingLeft: 0, right: nil, paddingRight: 0, width: 0, height: 0)
        logoImage.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        logoImage.heightAnchor.constraint(equalToConstant: 300).isActive = true
        logoImage.widthAnchor.constraint(equalToConstant: 300).isActive = true
        
        playView.anchor(top: logoImage.topAnchor, paddingTop: 280, bottom: nil, paddingBottom: 0, left: view.leftAnchor, paddingLeft: 40, right: view.rightAnchor, paddingRight: 40, width: 0, height: 50)
        
        assetView.anchor(top: playView.bottomAnchor, paddingTop: 24, bottom: nil, paddingBottom: 0, left: view.leftAnchor, paddingLeft: 40, right: view.rightAnchor, paddingRight: 40, width: 0, height: 50)
        
        marketView.anchor(top: assetView.bottomAnchor, paddingTop: 24, bottom: nil, paddingBottom: 0, left: view.leftAnchor, paddingLeft: 40, right: view.rightAnchor, paddingRight: 40, width: 0, height: 50)
        
        buttons.anchor(top: nil, paddingTop: 0, bottom: view.bottomAnchor, paddingBottom: 90, left: view.leftAnchor, paddingLeft: 40, right: view.rightAnchor, paddingRight: 40, width: 0, height: 50)
    }
}

