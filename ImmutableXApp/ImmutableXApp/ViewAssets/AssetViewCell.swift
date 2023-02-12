import UIKit

class AssetCell: UICollectionViewCell {
    
    lazy var imageView: UIImageView = {
        let imageView = UIImageView()
        imageView.image = UIImage(named: "github")
        imageView.contentMode = .scaleAspectFill
        imageView.layer.masksToBounds = true
        imageView.layer.cornerRadius = 8
        imageView.layer.shadowColor = UIColor.black.cgColor
        imageView.layer.shadowOpacity = 0.8
        imageView.layer.shadowRadius = 30
        imageView.layer.shadowOffset = CGSize(width: 1, height: 1)
        return imageView
    }()
    
    lazy var titleLabel: UILabel = {
        let text = UILabel()
        text.layout(colour: .black, size: 14, text: "Bruh", bold: false)
        return text
    }()
    
    lazy var desciptionLabel: UILabel = {
        let text = UILabel()
        text.layout(colour: .darkGray, size: 12, text: "Moin", bold: true)
        return text
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupView()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func configure(data: overview) {
        imageView.image = UIImage(named: data.image)
        titleLabel.text = data.title
        desciptionLabel.text = data.description
    }
    
    func setupView() {
        addSubview(imageView)
        addSubview(titleLabel)
        addSubview(desciptionLabel)
        
        imageView.anchor(top: topAnchor, paddingTop: 0, bottom: nil, paddingBottom: 0, left: leftAnchor, paddingLeft: 0, right: rightAnchor, paddingRight: 0, width: 0, height: 180)
        
        titleLabel.anchor(top: imageView.bottomAnchor, paddingTop: 4, bottom: nil, paddingBottom: 0, left: leftAnchor, paddingLeft: 0, right: nil, paddingRight: 0, width: 0, height: 0)
        
        desciptionLabel.anchor(top: titleLabel.bottomAnchor, paddingTop: 2, bottom: nil, paddingBottom: 0, left: leftAnchor, paddingLeft: 0, right: nil, paddingRight: 0, width: 0, height: 0)
    }
}

