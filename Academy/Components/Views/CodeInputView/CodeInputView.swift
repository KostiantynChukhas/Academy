//
//  CodeInputView.swift
//  Academy
//
//  Created by  on 31.03.2021.
//

import UIKit

@objc
protocol InputCodeViewDelegate: class {
    func codeView(sender: InputCodeView, didFinishInput code: String) -> Bool
}

@IBDesignable
class InputCodeView: UIControl {
    @IBInspectable open var length: Int = 4 {
        didSet {
            setupUI()
        }
    }

    @IBOutlet open weak var delegate: InputCodeViewDelegate?

    var stackView: UIStackView = {
        let stackView = UIStackView()
        stackView.axis = .horizontal
        stackView.distribution = .fillEqually
        stackView.backgroundColor = .clear
        stackView.spacing = 9
        stackView.autoresizingMask = [.flexibleWidth, .flexibleHeight]
        return stackView
    }()

    fileprivate var items: [CodeItemView] = []
    
    var code: String {
        get {
            let items = stackView.arrangedSubviews.map({$0 as! CodeItemView})
            let values = items.map({$0.textField.text ?? ""})
            return values.joined()
        }
        
        set {
            let array = newValue.map(String.init)
            for i in 0..<length {
                let item = stackView.arrangedSubviews[i] as! CodeItemView
                item.textField.text = i < array.count ? array[i] : ""
            }
            if !stackView.arrangedSubviews.compactMap({$0 as? UITextField}).filter({$0.isFirstResponder}).isEmpty {
                self.becomeFirstResponder()
            }
        }
    }

    override open func awakeFromNib() {
        super.awakeFromNib()
        setupUI()

        let tap = UITapGestureRecognizer(target: self, action: #selector(becomeFirstResponder))
        addGestureRecognizer(tap)
    }

    fileprivate func setupUI() {
        self.backgroundColor = .clear
        stackView.frame = self.bounds
        
        if stackView.superview == nil {
            addSubview(stackView)
        }
        
        stackView.arrangedSubviews.forEach{($0.removeFromSuperview())}

        for i in 0..<length {
            let itemView = generateItem()
            itemView.textField.deleteDelegate = self
            itemView.textField.delegate = self
            itemView.tag = i
            itemView.textField.tag = i
            stackView.addArrangedSubview(itemView)
        }
    }

    func generateItem() -> CodeItemView {
        let type = CodeItemView.self
        let typeStr = type.description().components(separatedBy: ".").last ?? ""
        let bundle = Bundle(for: type)
        return bundle.loadNibNamed(typeStr, owner: nil, options: nil)?.last as! CodeItemView
    }

    @discardableResult
    override open func becomeFirstResponder() -> Bool {
        let items = stackView.arrangedSubviews.map({$0 as! CodeItemView})
        return (items.filter({($0.textField.text ?? "").isEmpty}).first ?? items.last)!.becomeFirstResponder()
    }

    @discardableResult
    override open func resignFirstResponder() -> Bool {
        stackView.arrangedSubviews.forEach({$0.resignFirstResponder()})
        return true
    }

    override open func prepareForInterfaceBuilder() {
        super.prepareForInterfaceBuilder()
        setupUI()
    }
}

extension InputCodeView: UITextFieldDelegate, CodeTextFieldDelegate {

    public func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.endEditing(true)
        return true
    }
    
    public func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        if string == "" { //is backspace
            return true
        }

        if !textField.hasText {
            let index = textField.tag
            let item = stackView.arrangedSubviews[index] as! CodeItemView
            item.textField.text = string

            sendActions(for: .valueChanged)

            if index == length - 1 { //is last textfield
                if (delegate?.codeView(sender: self, didFinishInput: self.code) ?? false) {
                    
                }
                
                textField.resignFirstResponder()
                textField.endEditing(true)
                
                return false
            }

            _ = stackView.arrangedSubviews[index + 1].becomeFirstResponder()
        }

        return false
    }

    public func deleteBackward(sender: CodeTextField, prevValue: String?) {
        for i in 1..<length {
            let itemView = stackView.arrangedSubviews[i] as! CodeItemView

            guard itemView.textField.isFirstResponder, (prevValue?.isEmpty ?? true) else {
                continue
            }

            let prevItem = stackView.arrangedSubviews[i-1] as! CodeItemView
            if itemView.textField.text?.isEmpty ?? true {
                prevItem.textField.text = ""
                _ = prevItem.becomeFirstResponder()
            }
        }
        
        sendActions(for: .valueChanged)
    }
}
