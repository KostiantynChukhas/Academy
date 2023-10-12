//
//  AlertViewController.swift
//  Academy
//
//  Created by Sergey Pritula on 17.04.2021.
//

import UIKit

class AlertViewController: UIViewController {
    static func instantiate(with title: String, and message: String? = nil) -> AlertViewController {
        let controller: AlertViewController = Storyboard.alert.instantiate()
        
        controller.error = title
        controller.message = message
        
        controller.modalTransitionStyle = .crossDissolve
        controller.modalPresentationStyle = .overFullScreen
        
        return controller
    }
    
    @IBOutlet weak var contentView: UIView!
    @IBOutlet weak var okButton: UIButton!
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var messageLabel: UILabel!
    
    private var error: String? = nil
    private var message: String? = nil
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        self.titleLabel.text = error
        self.messageLabel.text = message
        
        contentView.layer.cornerRadius = Style.Radius.button
        okButton.layer.cornerRadius = Style.Radius.button
    }

    @IBAction func okButtonAction(_ sender: Any) {
        self.dismiss(animated: true, completion: nil)
    }
}
