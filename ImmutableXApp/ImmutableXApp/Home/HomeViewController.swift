import UIKit

class HomeViewController: UIViewController {
    
    lazy var topBarView: TopBarView = {
        let topBarView = TopBarView()
        return topBarView
    }()
    
    lazy var titleView: UILabel = {
        let text = UILabel()
        text.layout(colour: .black, size: 38, text: "Placeholder.", bold: true)
        return text
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
    
    lazy var buttons: GrayButtonsView = {
        let button = GrayButtonsView()
        return button
    }()
    
    @objc func didtapbox3() {
        
        DispatchQueue.main.async {
//            let storyboard = UIStoryboard(name: "Main", bundle: nil)
//            let destinationVC = storyboard.instantiateViewController(withIdentifier: "ARView") as! ViewController
            let vc = GameOverViewController()
            self.navigationController?.present(vc, animated: true)
        }
    }
    
    @objc func didtapbox2() {
        
        DispatchQueue.main.async {
//            let storyboard = UIStoryboard(name: "Main", bundle: nil)
//            let destinationVC = storyboard.instantiateViewController(withIdentifier: "ARView") as! ViewController
            let vc = AssetViewController()
            self.navigationController?.present(vc, animated: true)
        }
    }
    
    @objc func didtapbox() {
        
        DispatchQueue.main.async {
//            let storyboard = UIStoryboard(name: "Main", bundle: nil)
//            let destinationVC = storyboard.instantiateViewController(withIdentifier: "ARView") as! ViewController
            let vc = ProfileViewController()
            self.navigationController?.present(vc, animated: true)
        }
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        playView.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(didtapbox3)))
        assetView.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(didtapbox2)))
        buttons.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(didtapbox)))
        setUpView()
        view.backgroundColor = .white
    }
    func setUpView(){
        
        view.addSubview(topBarView)
        view.addSubview(titleView)
        view.addSubview(playView)
        view.addSubview(assetView)
        view.addSubview(buttons)

        topBarView.anchor(top: view.topAnchor, paddingTop: 70, bottom: nil, paddingBottom: 0, left: view.leftAnchor, paddingLeft: 32, right: view.rightAnchor, paddingRight: 16, width: 0, height: 0)
        
        titleView.anchor(top: topBarView.topAnchor, paddingTop: 130, bottom: nil, paddingBottom: 0, left: nil, paddingLeft: 0, right: nil, paddingRight: 0, width: 0, height: 0)
        titleView.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        
        playView.anchor(top: titleView.topAnchor, paddingTop: 250, bottom: nil, paddingBottom: 0, left: view.leftAnchor, paddingLeft: 40, right: view.rightAnchor, paddingRight: 40, width: 0, height: 50)
        
        assetView.anchor(top: playView.bottomAnchor, paddingTop: 24, bottom: nil, paddingBottom: 0, left: view.leftAnchor, paddingLeft: 40, right: view.rightAnchor, paddingRight: 40, width: 0, height: 50)
        
        buttons.anchor(top: nil, paddingTop: 0, bottom: view.bottomAnchor, paddingBottom: 100, left: view.leftAnchor, paddingLeft: 40, right: view.rightAnchor, paddingRight: 40, width: 0, height: 50)
    }
}

