

import UIKit

class MenuViewController: UIViewController {
    
    var viewModel: MenuViewModelType!
    
    @IBOutlet var myCardsButton: UIButton!
    @IBOutlet var servicesButtoon: UIButton!
    @IBOutlet var trainersButton: UIButton!
    @IBOutlet var scheduleButton: UIButton!
    @IBOutlet var contactsButton: UIButton!
    @IBOutlet var menuView: UIView!
    
    var buttonArray:[UIButton] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupButtons()
        setupMenuView()
    }
    
    private func setupGestureMenu() {
        let tap = UITapGestureRecognizer(target: self, action: #selector(self.menuViewTap(_:)))
        menuView.addGestureRecognizer(tap)
        let tapView = UITapGestureRecognizer(target: self, action: #selector(self.viewTap(_:)))
        self.view.addGestureRecognizer(tapView)
    }
    
    fileprivate func setupMenuView() {
        menuView.layer.addShadow()
        self.setupGestureMenu()
    }
    
    private func setupButtons() {
        buttonArray = [myCardsButton,servicesButtoon,trainersButton, scheduleButton, contactsButton]
        for button in buttonArray {
            button.setTitleColor(UIColor(named: "primaryColor"), for: .selected)
        }
    }
    
    private func hideMenu() {
        
        UIView.animate(withDuration: 0.3, animations: {
            self.view.layoutIfNeeded()
            self.menuView.alpha = CGFloat(0.0)
            
        }, completion: { value in
            self.viewModel.route(to: .dismiss)
        })
    }
    
    @objc func menuViewTap(_ sender: UITapGestureRecognizer? = nil) {
        // handling code
        self.hideMenu()
    }
    
    @objc func viewTap(_ sender: UITapGestureRecognizer? = nil) {
        // handling code
        self.hideMenu()
    }
    
    @IBAction func homeActionButton(_ sender: Any) {
        self.hideMenu()
        self.viewModel.route(to: .home)
    }
    
    @IBAction func myCardsButtonAction(_ sender: Any) {
        self.hideMenu()
        self.viewModel.route(to: .cards)
    }
    
    
    @IBAction func coachesButtonAction(_ sender: Any) {
        self.hideMenu()
        self.viewModel.route(to: .coaches)
    }
    
    @IBAction func scheduleButtonAction(_ sender: Any) {
        self.hideMenu()
        self.viewModel.route(to: .schedule)
    }
    
    @IBAction func contactsButtonAction(_ sender: Any) {
        self.hideMenu()
        self.viewModel.route(to: .contacts)
    }
    
    @IBAction func facebookActionButton(_ sender: Any) {
        if let url = URL(string: Defines.Links.facebook) {
            UIApplication.shared.open(url)
        }
    }
    
    @IBAction func instagramActionButton(_ sender: Any) {
        if let url = URL(string: Defines.Links.instagram) {
            UIApplication.shared.open(url)
        }
    }
    
    deinit {
        printDeinit(self)
    }
}
