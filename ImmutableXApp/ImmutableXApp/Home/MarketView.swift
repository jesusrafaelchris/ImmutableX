import UIKit

class MarketView: UIView {
    
    lazy var amountLabel: UILabel = {
        let text = UILabel()
        text.layout(colour: .white, size: 20, text: "Marketplace", bold: true)
        text.numberOfLines = 0
        text.translatesAutoresizingMaskIntoConstraints = false
        text.textAlignment = .center
        return text
    }()
    
    @objc func handleTap() {
        UIView.animate(withDuration: 0.1) {
          self.amountLabel.textColor = .lightGray
        }

        DispatchQueue.main.asyncAfter(deadline: .now() + 0.1) {
          UIView.animate(withDuration: 0.1) {
            self.amountLabel.textColor = .white
          }
        }
      }

    
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
