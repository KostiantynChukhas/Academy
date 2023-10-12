
import UIKit

extension CALayer {
    func addShadow(
        color: UIColor = .black,
        alpha: Float = 0.12,
        xShadow: CGFloat = 0,
        yShadow: CGFloat = 4,
        blur: CGFloat = 12,
        spread: CGFloat = 0
    ) {
        shadowColor = color.cgColor
        shadowOpacity = alpha
        shadowOffset = CGSize(width: xShadow, height: yShadow)
        shadowRadius = blur / 2.0
        shouldRasterize = true
        rasterizationScale = UIScreen.main.scale
        if spread == 0 {
            shadowPath = nil
        } else {
            let dx = -spread
            let rect = bounds.insetBy(dx: dx, dy: dx)
            shadowPath = UIBezierPath(rect: rect).cgPath
        }
    }
}

func getShadowLayer(
    for bounds: CGRect,
    color: UIColor = .black,
    alpha: Float = 0.12,
    xShadow: CGFloat = 0,
    yShadow: CGFloat = 4,
    blur: CGFloat = 12,
    spread: CGFloat = 0
) -> CAShapeLayer {
    let shadowLayer = CAShapeLayer()
    shadowLayer.shadowColor = color.cgColor
    shadowLayer.shadowOpacity = alpha
    shadowLayer.shadowOffset = CGSize(width: xShadow, height: yShadow)
    shadowLayer.shadowRadius = blur / 2.0
    if spread == 0 {
        shadowLayer.shadowPath = nil
    } else {
        let dx = -spread
        let rect = bounds.insetBy(dx: dx, dy: dx)
        shadowLayer.shadowPath = UIBezierPath(rect: rect).cgPath
    }
    return shadowLayer
}

extension UIView {

    func addShadow(offset: CGSize, color: UIColor, radius: CGFloat, opacity: Float) {
        layer.masksToBounds = false
        layer.shadowOffset = offset
        layer.shadowColor = color.cgColor
        layer.shadowRadius = radius
        layer.shadowOpacity = opacity

        let backgroundCGColor = backgroundColor?.cgColor
        backgroundColor = nil
        layer.backgroundColor =  backgroundCGColor
    }
}
