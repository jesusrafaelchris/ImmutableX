import UIKit

class TopBarView: UIView {

    lazy var profileImage: UIImageView = {
        let imageView = UIImageView()
        imageView.image = UIImage(named: "github")
        imageView.contentMode = .scaleAspectFill
        imageView.layer.masksToBounds = true
        imageView.layer.cornerRadius = 20
        return imageView
    }()

    lazy var dateLabel: UILabel = {
        let text = UILabel()
        text.layout(colour: .white, size: 16, text: "Nkoorty #0299", bold: false)
        return text
    }()

    lazy var titleLabel: UILabel = {
        let text = UILabel()
        text.layout(colour: .lightGray, size: 14, text: "Level 14", bold: true)
        return text
    }()
    
    lazy var progressBar: UIImageView = {
        let imageView = UIImageView()
        imageView.image = UIImage(named: "ProgressBar")
        imageView.contentMode = .scaleAspectFill
        imageView.layer.masksToBounds = true
        imageView.layer.cornerRadius = 20
        return imageView
    }()
    
    lazy var buttonStackView: UIStackView = {
        let stackView = UIStackView()
        stackView.axis = .horizontal
        stackView.distribution = .fill
        stackView.alignment = .leading
        stackView.spacing = 8
        stackView.addArrangedSubview(dateLabel)
        stackView.addArrangedSubview(titleLabel)
        return stackView
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        addSubview(profileImage)
        addSubview(dateLabel)
        addSubview(titleLabel)
        addSubview(progressBar)
        
        profileImage.anchor(top: nil, paddingTop: 0, bottom: nil, paddingBottom: 0, left: leftAnchor, paddingLeft: 0, right: nil, paddingRight: 0, width: 0, height: 0)
        profileImage.centerYAnchor.constraint(equalTo: centerYAnchor).isActive = true
        profileImage.heightAnchor.constraint(equalToConstant: 40).isActive = true
        profileImage.widthAnchor.constraint(equalToConstant: 40).isActive = true
        
        dateLabel.anchor(top: topAnchor, paddingTop: 0, bottom: nil, paddingBottom: 0, left: profileImage.rightAnchor, paddingLeft: 16, right: nil, paddingRight: 0, width: 0, height: 0)
        
        titleLabel.anchor(top: dateLabel.bottomAnchor, paddingTop: 4, bottom: bottomAnchor, paddingBottom: 0, left: profileImage.rightAnchor, paddingLeft: 16, right: nil, paddingRight: 0, width: 0, height: 0)
        
        progressBar.anchor(top: topAnchor, paddingTop: -58, bottom: nil, paddingBottom: 0, left: nil, paddingLeft: 0, right: rightAnchor, paddingRight: 25, width: 0, height: 0)
        progressBar.heightAnchor.constraint(equalToConstant: 200).isActive = true
        progressBar.widthAnchor.constraint(equalToConstant: 200).isActive = true

    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

}
