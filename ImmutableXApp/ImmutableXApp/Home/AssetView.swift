import UIKit

class AssetView: UIView {
    
    lazy var amountLabel: UILabel = {
        let text = UILabel()
        text.layout(colour: .white, size: 20, text: "My Assets", bold: true)
        text.numberOfLines = 0
        text.translatesAutoresizingMaskIntoConstraints = false
        text.textAlignment = .center
        return text
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.backgroundColor = UIColor.white.withAlphaComponent(0.3)
        layer.cornerRadius = 25
        layer.masksToBounds = true
        setUpView()
    }
    
    func setUpView() {
        addSubview(amountLabel)
        
       // amountLabel.anchor(top: topAnchor, paddingTop: 0, bottom: bottomAnchor, paddingBottom: 0, left: leftAnchor, paddingLeft: 0, right: rightAnchor, paddingRight: 0, width: 0, height: 0)
        
        amountLabel.centerYAnchor.constraint(equalTo: centerYAnchor, constant: 0).isActive = true
        amountLabel.centerXAnchor.constraint(equalTo: centerXAnchor).isActive = true
        
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
