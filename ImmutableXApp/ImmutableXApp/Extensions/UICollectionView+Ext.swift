import UIKit


extension UICollectionView {
    
    func addTopBorder() {
        let border = UIView()
        border.backgroundColor = .varsitySubtitle
        border.autoresizingMask = [.flexibleWidth, .flexibleBottomMargin]
        border.frame = CGRect(x: 0, y: 0, width: frame.size.width, height: 1)
        addSubview(border)
    }
}
