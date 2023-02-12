import UIKit

class StatsCell: UICollectionViewCell {

    lazy var imageView: UIImageView = {
        let imageView = UIImageView()
        imageView.image = UIImage(named: "Profile")
        imageView.contentMode = .scaleAspectFill
        imageView.layer.masksToBounds = true
        imageView.layer.cornerRadius = 10
        return imageView
    }()
    
    lazy var titleLabel: UILabel = {
        let text = UILabel()
        text.layout(colour: .black, size: 16, text: "Polygon X EasyA", bold: true)
        return text
    }()
    
    lazy var descriptionLabel: UILabel = {
        let text = UILabel()
        text.layout(colour: .darkGray, size: 12, text:
                    "Technology, Hackathon"
                    , bold: true)
        text.numberOfLines = 0
        return text
    }()

    lazy var statsChevron: UIButton = {
        let statsChevron = UIButton()
        statsChevron.setsizedImage(symbol: "chevron.right", size: 12, colour: .darkGray)
        statsChevron.translatesAutoresizingMaskIntoConstraints = false
        return statsChevron
    }()
    
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupView()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func configure(data: Stats) {
        imageView.image = UIImage(named: data.image)
        titleLabel.text = data.title
    }
    
    func setupView() {

        addSubview(imageView)
        addSubview(titleLabel)
        addSubview(statsChevron)
        
        imageView.anchor(top: topAnchor, paddingTop: 0, bottom: bottomAnchor, paddingBottom: 0, left: leftAnchor, paddingLeft: 0, right: nil, paddingRight: 0, width: 44, height: 44)
        
        titleLabel.anchor(top: topAnchor, paddingTop: 0, bottom: bottomAnchor, paddingBottom: 0, left: imageView.rightAnchor, paddingLeft: 20, right: rightAnchor, paddingRight: 0, width: 0, height: 0)

        statsChevron.anchor(top: topAnchor, paddingTop: 0, bottom: bottomAnchor, paddingBottom: 0, left: nil, paddingLeft: 0, right: rightAnchor, paddingRight: 5, width: 0, height: 0)
        statsChevron.centerYAnchor.constraint(equalTo: imageView.centerYAnchor).isActive = true
    }
}
