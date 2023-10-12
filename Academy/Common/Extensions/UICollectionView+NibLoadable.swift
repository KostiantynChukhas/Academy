//
//  UICollectionViewCell+NibLoadableView.swift
//  Hydra_iOS
//
//  Created by  on 22.03.2021.
//

import UIKit

extension UICollectionViewCell: NibLoadableView {}

extension UICollectionViewCell {
    static var identifier: String {
        return String(describing: self)
    }
}

extension UICollectionView {
    func registerNib<T: UICollectionViewCell>(_ cellType: T.Type) {
        register(UINib(nibName: cellType.nibName, bundle: nil), forCellWithReuseIdentifier: cellType.nibName)
    }
    
    func register<T: UICollectionViewCell>(_ cellType: T.Type) {
        register(cellType, forCellWithReuseIdentifier: cellType.identifier)
    }
    

    func dequeCell<T: UICollectionViewCell>(for indexPath: IndexPath) -> T? {
        guard let cell = dequeueReusableCell(withReuseIdentifier: T.nibName, for: indexPath) as? T else {
            return nil
        }

        return cell
    }
}
