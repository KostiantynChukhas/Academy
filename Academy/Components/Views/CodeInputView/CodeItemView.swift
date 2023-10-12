//
//  SwiftyCodeItemView.swift
//
//  Created by arturdev on 6/28/18.
//

import UIKit

open class CodeItemView: UIView {

    @IBOutlet weak var textField: CodeTextField!
    
    override open func awakeFromNib() {
        super.awakeFromNib()
        
        textField.text = ""
        textField.tintColor = UIColor.lightGray
        textField.layer.cornerRadius = Style.Radius.textField
        
        backgroundColor = .clear
        isUserInteractionEnabled = false
    }
    
    override open func becomeFirstResponder() -> Bool {
        return textField.becomeFirstResponder()
    }
    
    override open func resignFirstResponder() -> Bool {
        return textField.resignFirstResponder()
    }
}
