//
//  SmsVerificationViewController.swift
//  Academy
//
//  Created by  on 31.03.2021.
//

import UIKit

class SmsVerificationViewController: UIViewController {
    var viewModel: SmsVerificationViewModelType!
    
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var codeDescriptionLabel: UILabel!
    @IBOutlet weak var phoneLabel: UILabel!
    @IBOutlet weak var continueButton: BMButton!
    @IBOutlet weak var resendButton: UIButton!
    @IBOutlet weak var inputCodeView: InputCodeView!
    
    private var timer: Timer?
    private var seconds = 60
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Do any additional setup after loading the view.
        setup()
    }
    
    private func setup() {
        timer = Timer.scheduledTimer(timeInterval: 1.0, target: self, selector: #selector(fireTimer), userInfo: nil, repeats: true)
        
        continueButton.layer.cornerRadius = Style.Radius.button
        
        resendButton.titleLabel?.lineBreakMode = .byWordWrapping
        resendButton.titleLabel?.textAlignment = .center
        
        inputCodeView.delegate = self
        inputCodeView.becomeFirstResponder()
        
        phoneLabel.text = viewModel.phone
        continueButton.backgroundColor = Style.Color.primaryColor.withAlphaComponent(0.7)
    }
    
    @IBAction func continueButtonAction(_ sender: Any) {
        guard inputCodeView.code.count == 4 else { return }
        continueButton.buttonState = .active
        continueButton.showLoading()
        
        viewModel.login(code: inputCodeView.code) { (result) in
            DispatchQueue.main.async {
                switch result {
                case .success:
                    self.viewModel.route(to: .home)
                    self.continueButton.buttonState = .loadingFinished
                case .failure(let error):
                    AlertHelper.showAlert(msg: error.localizedDescription)
                    self.continueButton.buttonState = .loadingFinished
                }
            }
        }
    }
    
    @IBAction func codeChanged(_ sender: Any) {
        let color = Style.Color.primaryColor
        let isEnabled = inputCodeView.code.count == 4
        
        continueButton.isEnabled = isEnabled
        continueButton.backgroundColor = isEnabled ? color: color.withAlphaComponent(0.7)
    }
    
    @IBAction func resendButtonAction(_ sender: Any) {
        if seconds == 0 {
            seconds = 60
            timer = Timer.scheduledTimer(timeInterval: 1.0, target: self, selector: #selector(fireTimer), userInfo: nil, repeats: true)

            viewModel.resend()
        }
    }
    
    @objc
    private func fireTimer() {
        seconds -= 1
        
        if seconds == 0 {
            timer?.invalidate()
        }
        
        display()
    }
    
    private func display() {
        let color = seconds == 0 ? Style.Color.primaryColor: Style.Color.lightGreyColor
        let title = seconds == 0 ? "Вислати пароль повторно" : "Ви зможете отримати пароль повторно\nчерез \(seconds) секунд"
        
        UIView.performWithoutAnimation { [weak self] in
            self?.resendButton.setTitleColor(color, for: .normal)
            self?.resendButton.setTitle(title, for: .normal)
        }
    }
    
    deinit {
        printDeinit(self)
    }
}

// MARK: - InputCodeViewDelegate -

extension SmsVerificationViewController: InputCodeViewDelegate {
    func codeView(sender: InputCodeView, didFinishInput code: String) -> Bool {
        return true
    }
    
}
