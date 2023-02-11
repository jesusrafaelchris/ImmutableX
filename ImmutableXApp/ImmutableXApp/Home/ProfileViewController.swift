import UIKit

class ProfileViewController: UIViewController {
    
    lazy var titleLabel: UILabel = {
        let title = UILabel()
        title.layout(colour: .black, size: 28, text: "Profile", bold: true)
        return title
    }()
    
    lazy var topBarView: ProfileView = {
        let topBarView = ProfileView()
        return topBarView
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setUpView()
        view.backgroundColor = .white
    }
    
    func setUpView() {
        
        view.addSubview(titleLabel)
        view.addSubview(topBarView)
        
        titleLabel.anchor(top: view.safeAreaLayoutGuide.topAnchor, paddingTop: 40, bottom: nil, paddingBottom: 0, left: view.safeAreaLayoutGuide.leftAnchor, paddingLeft: 24, right: nil, paddingRight: 0, width: 0, height: 0)
        
        topBarView.anchor(top: titleLabel.bottomAnchor, paddingTop: 60, bottom: nil, paddingBottom: 0, left: titleLabel.leftAnchor, paddingLeft: 0, right: nil, paddingRight: 0, width: 0, height: 0)
        
    }
}
