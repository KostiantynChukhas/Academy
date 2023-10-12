//
//  Style.swift
//  Academy
//
//  Created by  on 31.03.2021.
//

import UIKit

struct Style {
    enum Padding {
        static let content: CGFloat = 30
    }
    
    enum Radius {
        static let textField: CGFloat = 10
        static let button: CGFloat = 10
        static let navigation: CGFloat = 10
        static let tabBar: CGFloat = 10
        static let container: CGFloat = 10
        static let defaultRadius: CGFloat = 10
    }
    
    enum Color {
        static let backgroundColor = UIColor(named: "backgroundColor")!
        static let primaryColor = UIColor(named: "primaryColor")!
        static let black = UIColor(named: "black")!
        static let lightGreyColor = UIColor(named: "lightGreyColor")!
    }
}

// MARK: - disabledColor -

extension UIColor {
    var disabledColor: UIColor {
        return self.withAlphaComponent(0.7)
    }
}
