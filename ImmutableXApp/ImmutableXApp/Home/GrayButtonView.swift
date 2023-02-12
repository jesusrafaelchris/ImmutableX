import UIKit

class GrayButtonsView: UIView {
    
    let button1 = GrayButtonTextView()
    let button2 = GrayButtonTextView()
    let button3 = GrayButtonTextView()
    let button4 = GrayButtonTextView()
    
    lazy var buttonStackView: UIStackView = {
        let stackView = UIStackView()
        stackView.axis = .horizontal
        stackView.distribution = .fillEqually
        stackView.alignment = .center
        stackView.spacing = 15
        stackView.addArrangedSubview(button1)
        stackView.addArrangedSubview(button2)
        stackView.addArrangedSubview(button3)
        stackView.addArrangedSubview(button4)
        return stackView
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        addSubview(buttonStackView)
        buttonStackView.anchor(top: topAnchor, paddingTop: 0, bottom: nil, paddingBottom: 0, left: leftAnchor, paddingLeft: 0, right: rightAnchor, paddingRight: 0, width: 0, height: 0)
        
        button1.configure(image: "gear", label: "")
        button2.configure(image: "speaker.wave.2", label: "")
        button3.configure(image: "person.fill", label: "")
        button4.configure(image: "gift", label: "")
        
    }
    
    required init(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}

