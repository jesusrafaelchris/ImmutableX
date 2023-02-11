import UIKit

class GrayButton:UIButton {
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        makeSize(size: 50)
    }
    
    required init(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func configure(image: String){
        layout(textcolour: .clear, backgroundColour: .black.withAlphaComponent(0.1), size: 80, text: "", image: UIImage(systemName: image)?.withTintColor(.black).withRenderingMode(.alwaysOriginal), cornerRadius: 25)
    }
    
}
