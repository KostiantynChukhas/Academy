//
//  UITableViewCell+NibLoadableView.swift
//  Hydra_iOS
//
//  Created by  on 22.03.2021.
//

import UIKit

extension UITableViewCell: NibLoadableView {}

extension UITableViewCell {
    static var reuseIdentifier: String { return String(describing: self) }
}

extension UITableView {
    func registerNib<T: UITableViewCell>(cellType _: T.Type) {
        register(UINib(nibName: T.nibName, bundle: nil), forCellReuseIdentifier: T.reuseIdentifier)
    }

    func dequeCell<T: UITableViewCell>(for indexPath: IndexPath) -> T? {
        guard let cell = dequeueReusableCell(withIdentifier: T.nibName, for: indexPath) as? T else {
            return nil
        }

        return cell
    }
}

extension UICollectionView {
    func registerCells(_ cells: [String]) {
        cells.forEach {
            self.register(UINib(nibName: $0, bundle: nil), forCellWithReuseIdentifier: $0)
        }
    }
}
