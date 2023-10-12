
import UIKit

enum BMButtonState {
    case `default`
    case active
    case loading
    case loadingFinished
}

@IBDesignable class BMButton: UIButton {
    @IBInspectable var activityIndicatorColor: UIColor = .white
    
    @IBInspectable var cornerRadius: CGFloat = 10 {
           didSet {
              layer.cornerRadius = cornerRadius
           }
       }
    
    @IBInspectable var backgroundcolor: UIColor = UIColor.clear {
          didSet {
            self.layer.backgroundColor = backgroundcolor.cgColor
          }
        }
    
    var activityIndicator: UIActivityIndicatorView?
    
    var isActive: Bool = false {
        didSet {
            if isActive {
                self.buttonState = .active
            } else {
                self.buttonState = .default
            }
        }
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        customInit()
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        customInit()
    }
    
    private func customInit() {
        self.layer.cornerRadius = Style.Radius.defaultRadius
    }
    
    var buttonState: BMButtonState = .default {
        didSet {
            switch buttonState {
            case .default:
                alpha = 0.7
                titleLabel?.isHidden = false
                isUserInteractionEnabled = false
            case .active:
                alpha = 1.0
                titleLabel?.isHidden = false
                isUserInteractionEnabled = true
            case .loading:
                showLoading()
            case .loadingFinished:
                hideLoading()
            }
        }
    }
    
    func showLoading() {
        titleLabel?.alpha = 0
        setTitleColor(UIColor.clear, for: .normal)
        isUserInteractionEnabled = false
        
        if (activityIndicator == nil) {
            activityIndicator = createActivityIndicator()
        }
        
        showSpinning()
    }
    
    func hideLoading() {
        titleLabel?.alpha = 1.0
        setTitleColor(UIColor.white, for: .normal)
        isUserInteractionEnabled = true
        
        activityIndicator?.stopAnimating()
    }
    
    private func createActivityIndicator() -> UIActivityIndicatorView {
        let activityIndicator = UIActivityIndicatorView()
        
        activityIndicator.style = .whiteLarge
        activityIndicator.hidesWhenStopped = true
        activityIndicator.color = activityIndicatorColor
        
        return activityIndicator
    }
    
    private func showSpinning() {
        guard let activityIndicator = activityIndicator else {
            return
        }
        
        activityIndicator.translatesAutoresizingMaskIntoConstraints = false
        self.addSubview(activityIndicator)
        centerActivityIndicatorInButton()
        activityIndicator.startAnimating()
    }
    
    private func centerActivityIndicatorInButton() {
        let xCenterConstraint = NSLayoutConstraint(item: self,
                                                   attribute: .centerX,
                                                   relatedBy: .equal,
                                                   toItem: activityIndicator,
                                                   attribute: .centerX,
                                                   multiplier: 1, constant: 0)
        self.addConstraint(xCenterConstraint)
        
        let yCenterConstraint = NSLayoutConstraint(item: self,
                                                   attribute: .centerY,
                                                   relatedBy: .equal,
                                                   toItem: activityIndicator,
                                                   attribute: .centerY,
                                                   multiplier: 1, constant: 0)
        self.addConstraint(yCenterConstraint)
    }
    
}
