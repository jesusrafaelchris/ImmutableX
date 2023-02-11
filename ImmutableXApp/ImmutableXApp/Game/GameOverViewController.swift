import UIKit

class GameOverViewController: UIViewController, GameOverViewDelegate {
    func GoHome() {
        navigationController?.popViewController(animated: true)
    }
    
    func tryAgain() {
        self.dismiss(animated: true)
    }
    
    lazy var gameoverView: GameOverView = {
        let view = GameOverView()
        view.delegate = self
        return view
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setUpView()
        view.backgroundColor = .clear
    }
    
    func setUpView() {
        view.addSubview(gameoverView)
        
        gameoverView.anchor(top: view.topAnchor, paddingTop: 280, bottom: nil, paddingBottom: 0, left: nil, paddingLeft: 0, right: nil, paddingRight: 0, width: 300, height: 175)
        gameoverView.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true

    }
}
