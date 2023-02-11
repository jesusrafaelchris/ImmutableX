import UIKit

// Extension for laying out UIButton
extension UIButton {
    func layout(textcolour: UIColor?, backgroundColour: UIColor?, size: CGFloat?, text: String?, image: UIImage?, cornerRadius: CGFloat?) {
        setTitle(text, for: .normal)
        setTitleColor(textcolour, for: .normal)
        if let size = size {
            titleLabel?.font = UIFont.boldSystemFont(ofSize: size)
        }

        setImage(image, for: .normal)
        if let radius = cornerRadius {
        layer.cornerRadius = radius
        }
        layer.masksToBounds = true
        backgroundColor = backgroundColour

    }
    
    func setsizedImage(symbol: String, size: CGFloat, colour: UIColor) {
        let largeConfig = UIImage.SymbolConfiguration(pointSize: size, weight: .bold, scale: .large)
        let largeBoldDoc = UIImage(systemName: symbol, withConfiguration: largeConfig)?.withTintColor(colour).withRenderingMode(.alwaysOriginal)
        self.setImage(largeBoldDoc, for: .normal)
    }
    
    func addPadding(_ padding: CGFloat) {
        titleEdgeInsets = UIEdgeInsets(top: padding, left: padding, bottom: padding, right: padding)
        contentEdgeInsets = UIEdgeInsets(top: padding * 2, left: padding * 2, bottom: padding * 2, right: padding * 2)
    }
}
