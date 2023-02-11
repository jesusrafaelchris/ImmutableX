import UIKit

class GrayButtonTextView: UIView {
    
    let button = GrayButton()
    
    lazy var buttonLabel: UILabel = {
        let label = UILabel()
        label.layout(colour: .darkGray, size: 12, text: "", bold: false)
        return label
    }()
    
    lazy var buttonStackView: UIStackView = {
        let stackView = UIStackView()
        stackView.axis = .vertical
        stackView.distribution = .equalSpacing
        stackView.alignment = .center
        stackView.spacing = 4
        stackView.addArrangedSubview(button)
        stackView.addArrangedSubview(buttonLabel)
        return stackView
    }()
    
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        addSubview(buttonStackView)
        
        buttonStackView.anchor(top: topAnchor, paddingTop: 0, bottom: nil, paddingBottom: 0, left: leftAnchor, paddingLeft: 0, right: rightAnchor, paddingRight: 0, width: 0, height: 0)
    }
    
    required init(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func configure(image: String, label: String) {
        
        button.configure(image: image)
        buttonLabel.text = label
    }
    
}
