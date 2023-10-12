//
//  NSMutableAttributedString.swift
//  Academy
//
//  Created by Konstantin Chukhas on 14.11.2021.
//

import UIKit

private let fontSize: CGFloat = 17

extension NSMutableAttributedString {
    
    func normalMonserrat(_ value: String, size: CGFloat = fontSize, color: UIColor? = nil, alignment: NSTextAlignment? = .center) -> NSMutableAttributedString {
        let paragraph = NSMutableParagraphStyle()
        paragraph.alignment = alignment ?? .left
        
        var attributes:[NSAttributedString.Key : Any] = [
            .font : UIFont(name: "Montserrat-Regular", size: size) ?? .systemFont(ofSize: size), .paragraphStyle: paragraph,]
        if let color = color {
            attributes[.foregroundColor] =  color
        }
        
        self.append(NSAttributedString(string: value, attributes:attributes))
        return self
    }
    
    func boldMonserrat(_ value: String, size: CGFloat = fontSize, color: UIColor? = nil, alignment: NSTextAlignment? = .center) -> NSMutableAttributedString {
        let paragraph = NSMutableParagraphStyle()
        paragraph.alignment = alignment ?? .left
        
        var attributes:[NSAttributedString.Key : Any] = [
            .font :  UIFont(name: "Montserrat-Bold", size: size) ?? .boldSystemFont(ofSize: size), .paragraphStyle: paragraph,
        ]
        if let color = color {
            attributes[.foregroundColor] =  color
        }
        
        self.append(NSAttributedString(string: value, attributes:attributes))
        return self
    }
    
    func semiboldMonserrat(_ value: String, size: CGFloat = fontSize, color: UIColor? = nil, alignment: NSTextAlignment? = .center) -> NSMutableAttributedString {
        let paragraph = NSMutableParagraphStyle()
        paragraph.alignment = alignment ?? .left
        
        var attributes:[NSAttributedString.Key : Any] = [
            .font :  UIFont(name: "Montserrat-SemiBold", size: size) ?? .systemFont(ofSize: size), .paragraphStyle: paragraph,
        ]
        if let color = color {
            attributes[.foregroundColor] =  color
        }
        
        self.append(NSAttributedString(string: value, attributes:attributes))
        return self
    }
}

