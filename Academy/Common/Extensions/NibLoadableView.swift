//
//  NibLoadableView.swift
//  Hydra_iOS
//
//  Created by  on 22.03.2021.
//

import UIKit

protocol NibLoadableView {
    static var nibName: String { get }
}

extension NibLoadableView where Self: UIView {
    static var nibName: String {
        return String(describing: self)
    }
}
