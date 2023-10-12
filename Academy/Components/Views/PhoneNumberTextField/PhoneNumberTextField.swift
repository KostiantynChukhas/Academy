//
//  PhoneNumberTextField.swift
//  Academy
//
//  Created by Sergey Pritula on 04.04.2021.
//

import UIKit

protocol PhoneNumberTextFieldDelegate: class {
    func didValueChange(textField: PhoneNumberTextField, text: String)
}

class PhoneNumberTextField: UITextField {
    weak var phoneDelegate: PhoneNumberTextFieldDelegate?
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        delegate = self
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        delegate = self
    }
}

// MARK: - UITextFieldDelegate -

extension PhoneNumberTextField: UITextFieldDelegate {
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.endEditing(true)
        return true
    }
    
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        guard let text = textField.text else { return false }
       
        let newString = (text as NSString).replacingCharacters(in: range, with: string)
        let phone = format(with: "+XX XXX XX XX XXX", phone: newString)
        
        textField.text = phone
        
        phoneDelegate?.didValueChange(textField: self, text: phone)
        
        return false
    }
}
