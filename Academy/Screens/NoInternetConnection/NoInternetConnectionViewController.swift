

import UIKit

class NoInternetConnectionViewController: UIViewController {
    
    @IBOutlet var tryAgainButton: UIButton!
    var viewModel: NoInternetConnectionViewModelType!
    
    fileprivate func setupStatusBar() {
        if #available(iOS 13, *)
        {
            let statusBar = UIView(frame: (UIApplication.shared.keyWindow?.windowScene?.statusBarManager?.statusBarFrame)!)
            statusBar.backgroundColor = UIColor(named: "backgroundColor")
            UIApplication.shared.keyWindow?.addSubview(statusBar)
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupButton()
        setupStatusBar()
    }
    
    private func setupButton() {
        self.tryAgainButton.roundAll(radius: 10)
    }
    
    @IBAction func tryAgainButtonAction(_ sender: UIButton) {
    }
    
    deinit {
        printDeinit(self)
    }
}
