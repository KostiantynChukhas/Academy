//
//  AcademyButton.swift
//  Academy
//
//  Created by  on 31.03.2021.
//

import UIKit

@IBDesignable
class AcademyButton: UIButton {
    override var isSelected: Bool {
        didSet {
            alpha = isSelected ? 1 : 0.5
        }
    }
    
    @IBInspectable var radius: CGFloat = Style.Radius.button {
        didSet {
            self.layer.cornerRadius = radius
        }
    }
    
    override func titleColor(for state: UIControl.State) -> UIColor? {
        return .white
    }
    
    deinit {
        printDeinit(self)
    }
}
