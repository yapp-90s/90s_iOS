//
//  Reusable.swift
//  90s
//
//  Created by woongs on 2021/10/04.
//

import UIKit

protocol Reusable: AnyObject { }

extension Reusable where Self: UIView {
    
    static var reuseIdentifier: String {
        return "\(self)"
    }
}

// MARK: - UICollectionViewCell, UICollectionView

extension UICollectionViewCell: Reusable { }

extension UICollectionView {
    
    func dequeueReusableCell<T: UICollectionViewCell>(_ type: T.Type, forIndexPath indexPath: IndexPath) -> T {
        guard let cell = dequeueReusableCell(withReuseIdentifier: T.reuseIdentifier, for: indexPath) as? T else {
            fatalError("Could not dequeue cell with identifier: \(T.reuseIdentifier)")
        }
        return cell
    }
    
    func register<T: UICollectionViewCell>(reusable: T.Type) {
        self.register(T.self, forCellWithReuseIdentifier: T.reuseIdentifier)
    }
    
    func registerHeader<T: UICollectionViewCell>(reusable: T.Type) {
        self.register(T.self, forSupplementaryViewOfKind: UICollectionView.elementKindSectionHeader, withReuseIdentifier: T.reuseIdentifier)
    }
}

// MARK: - UITableViewCell, UITableView

extension UITableViewCell: Reusable { }

extension UITableViewHeaderFooterView: Reusable { }

extension UITableView {
    
    func dequeueReusableCell<T: UITableViewCell>(_ type: T.Type, forIndexPath indexPath: IndexPath) -> T {
        guard let cell = dequeueReusableCell(withIdentifier: T.reuseIdentifier, for: indexPath) as? T else {
            fatalError("Could not dequeue cell with identifier: \(T.reuseIdentifier)")
        }
        return cell
    }
    
    func register<T: UITableViewCell>(reusable: T.Type) {
        self.register(T.self, forCellReuseIdentifier: T.reuseIdentifier)
    }
    
    func registerHeader<T: UITableViewHeaderFooterView>(reusable: T.Type) {
        self.register(T.self, forHeaderFooterViewReuseIdentifier: T.reuseIdentifier)
    }
}
