//
//  LoginViewController.swift
//  Academy
//
//  Created by  on 31.03.2021.
//

import UIKit

class LoginViewController: UIViewController {
    var viewModel: LoginViewModelType!
    
    @IBOutlet weak var logInLabel: UILabel!
    @IBOutlet weak var descriptionLabel: UILabel!
    
    @IBOutlet weak var phoneNumberTextField: PhoneNumberTextField!
    @IBOutlet weak var logInButton: BMButton!
    @IBOutlet weak var skipButton: BMButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Do any additional setup after loading the view.
        setup()
    }
    
    private func setup() {
        let buttonConfigurator: (UIButton) -> () = { button in
            button.layer.cornerRadius = Style.Radius.button
        }
        
        buttonConfigurator(skipButton)
        buttonConfigurator(logInButton)
        
        phoneNumberTextField.keyboardType = .numberPad
        phoneNumberTextField.layer.cornerRadius = Style.Radius.textField
        phoneNumberTextField.phoneDelegate = self
        
        logInButton.backgroundColor = Style.Color.primaryColor.withAlphaComponent(0.7)
        logInButton.isEnabled = false
       
    }
    
    @IBAction func signInButtonAction(_ sender: Any) {
        guard let text = self.phoneNumberTextField.text else { return }
        logInButton.buttonState = .active
        logInButton.showLoading()
        
        self.viewModel.login(phone: text) { [weak self] result in
            DispatchQueue.main.async {
                switch result {
                case .success(let id):
                    self?.logInButton.buttonState = .loadingFinished
                    self?.viewModel.route(to: .smsVerification(phone: text, authId: id))
                case .failure(let error):
                    AlertHelper.showAlert(msg: error.localizedDescription)
                    self?.logInButton.buttonState = .loadingFinished
                }
            }
        }
    }
    
    @IBAction func skipButtonAction(_ sender: Any) {
        self.viewModel.route(to: .registration)
    }
    
    deinit {
        printDeinit(self)
    }
    
}
 
// MARK: - PhoneNumberTextFieldDelegate -

extension LoginViewController: PhoneNumberTextFieldDelegate {
    
    func didValueChange(textField: PhoneNumberTextField, text: String) {
        let color = Style.Color.primaryColor
        let isEnabled = text.replacingOccurrences(of: " ", with: "").count >= 12
        
        logInButton.isEnabled = isEnabled
        logInButton.backgroundColor = isEnabled ? color: color.withAlphaComponent(0.7)
    }
}
