//
//  SwiftyCodeTextField.swift
//
//  Created by arturdev on 6/30/18.
//

import UIKit

protocol CodeTextFieldDelegate: class {
	func deleteBackward(sender: CodeTextField, prevValue: String?)
}

class CodeTextField: UITextField {
    
    weak var deleteDelegate: CodeTextFieldDelegate?
    
    override open func deleteBackward() {
		let prevValue = text
		super.deleteBackward()
        deleteDelegate?.deleteBackward(sender: self, prevValue: prevValue)
    }
}
