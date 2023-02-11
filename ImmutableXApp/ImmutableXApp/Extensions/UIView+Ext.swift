import UIKit

// Extension that turns layout constraints into one line function
extension UIView {
    
    func pinEdgesToSuperView() {
        guard let superView = superview else { return }
        translatesAutoresizingMaskIntoConstraints = false
        topAnchor.constraint(equalTo: superView.topAnchor).isActive = true
        leftAnchor.constraint(equalTo: superView.leftAnchor).isActive = true
        bottomAnchor.constraint(equalTo: superView.bottomAnchor).isActive = true
        rightAnchor.constraint(equalTo: superView.rightAnchor).isActive = true
    }
    
    // swiftlint:disable function_parameter_count
    func anchor(top: NSLayoutYAxisAnchor?, paddingTop: CGFloat, bottom: NSLayoutYAxisAnchor?, paddingBottom: CGFloat, left: NSLayoutXAxisAnchor?, paddingLeft: CGFloat, right: NSLayoutXAxisAnchor?, paddingRight: CGFloat, width: CGFloat, height: CGFloat) {
    translatesAutoresizingMaskIntoConstraints = false
        
    if let top = top {
    topAnchor.constraint(equalTo: top, constant: paddingTop).isActive = true
        }
        
    if let bottom = bottom {
    bottomAnchor.constraint(equalTo: bottom, constant: -paddingBottom).isActive = true
        }
        
    if let right = right {
    rightAnchor.constraint(equalTo: right, constant: -paddingRight).isActive = true
        }
        
    if let left = left {
    leftAnchor.constraint(equalTo: left, constant: paddingLeft).isActive = true
        }
        
    if width != 0 {
    widthAnchor.constraint(equalToConstant: width).isActive = true
        }
        
    if height != 0 {
    heightAnchor.constraint(equalToConstant: height).isActive = true
        }
    }
    
    func makeSize(size: CGFloat) {
        translatesAutoresizingMaskIntoConstraints = false
        if size != 0 {
            widthAnchor.constraint(equalToConstant: size).isActive = true
            heightAnchor.constraint(equalToConstant: size).isActive = true
        }
    }
    
    func makewidth(size: CGFloat) {
        translatesAutoresizingMaskIntoConstraints = false
        if size != 0 {
            widthAnchor.constraint(equalToConstant: size).isActive = true
        }
    }
    
    func makeHeight(size: CGFloat) {
        translatesAutoresizingMaskIntoConstraints = false
        if size != 0 {
            heightAnchor.constraint(equalToConstant: size).isActive = true
        }
    }
}

var vSpinner : UIView?
extension UIViewController {
    
    func showSpinner(onView : UIView) {
        let spinnerView = UIView.init(frame: onView.bounds)
        spinnerView.backgroundColor = .black.withAlphaComponent(0.5)
        let ai = UIActivityIndicatorView.init(style: UIActivityIndicatorView.Style.large)
        ai.color = .orange
        ai.startAnimating()
        ai.center = spinnerView.center
        
        DispatchQueue.main.async {
            spinnerView.addSubview(ai)
            onView.addSubview(spinnerView)
        }
        
        vSpinner = spinnerView
    }
    
    func removeSpinner() {
        DispatchQueue.main.async {
            vSpinner?.removeFromSuperview()
            vSpinner = nil
        }
    }
}

