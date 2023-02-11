import UIKit

protocol GameOverViewDelegate: AnyObject {
    func GoHome()
    func tryAgain()
}

class GameOverView: UIView {
    
    weak var delegate: GameOverViewDelegate?
    
    lazy var gameOverLabel: UILabel = {
        let text = UILabel()
        text.font = UIFont.boldSystemFont(ofSize: 26)
        text.text = "Game Over"
        text.textColor = .white
        text.numberOfLines = 0
        text.translatesAutoresizingMaskIntoConstraints = false
        text.textAlignment = .center
        return text
    }()
    
    lazy var tryAgainLabel: UILabel = {
        let text = UILabel()
        text.font = UIFont.boldSystemFont(ofSize: 20)
        text.text = "Try Again"
        text.textColor = .white
        text.numberOfLines = 0
        text.translatesAutoresizingMaskIntoConstraints = false
        text.textAlignment = .center
        text.isUserInteractionEnabled = true
        text.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(tryAgain)))
        return text
    }()
    
    lazy var goHomeLabel: UILabel = {
        let text = UILabel()
        text.font = UIFont.boldSystemFont(ofSize: 20)
        text.text = "Go Home"
        text.textColor = .white
        text.numberOfLines = 0
        text.translatesAutoresizingMaskIntoConstraints = false
        text.textAlignment = .center
        text.isUserInteractionEnabled = true
        text.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(goHome)))
        return text
    }()

    override init(frame: CGRect) {
        super.init(frame: frame)
        layer.cornerRadius = 25
        layer.masksToBounds = true
        setUpView()
    }
    
    @objc func tryAgain() {
        print("try again")
        delegate?.tryAgain()
    }
    
    @objc func goHome() {
        print("go home")
        delegate?.GoHome()
    }
    
    private lazy var backgroundImageView: UIImageView = {
        let imageView = UIImageView(image: UIImage(named: "Background"))
        imageView.contentMode = .scaleAspectFill
        imageView.translatesAutoresizingMaskIntoConstraints = false
        return imageView
    }()
    
    func setUpView() {
        
        backgroundImageView.addSubview(gameOverLabel)
        backgroundImageView.addSubview(tryAgainLabel)
        backgroundImageView.addSubview(goHomeLabel)
        addSubview(backgroundImageView)
        
        backgroundImageView.topAnchor.constraint(equalTo: topAnchor).isActive = true
        backgroundImageView.bottomAnchor.constraint(equalTo: bottomAnchor).isActive = true
        backgroundImageView.leftAnchor.constraint(equalTo: leftAnchor).isActive = true
        backgroundImageView.rightAnchor.constraint(equalTo: rightAnchor).isActive = true
        
       // amountLabel.anchor(top: topAnchor, paddingTop: 0, bottom: bottomAnchor, paddingBottom: 0, left: leftAnchor, paddingLeft: 0, right: rightAnchor, paddingRight: 0, width: 0, height: 0)
        
        gameOverLabel.centerYAnchor.constraint(equalTo: centerYAnchor, constant: -50).isActive = true
        gameOverLabel.centerXAnchor.constraint(equalTo: centerXAnchor).isActive = true
        
        tryAgainLabel.centerYAnchor.constraint(equalTo: centerYAnchor, constant: 40).isActive = true
        tryAgainLabel.centerXAnchor.constraint(equalTo: centerXAnchor, constant: -80).isActive = true
        
        goHomeLabel.centerYAnchor.constraint(equalTo: centerYAnchor, constant: 40).isActive = true
        goHomeLabel.centerXAnchor.constraint(equalTo: centerXAnchor, constant: 80).isActive = true
        
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
