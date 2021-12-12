//
//  UINavigationController+.swift
//  90s
//
//  Created by woongs on 2021/12/12.
//

import UIKit

extension UINavigationController {
    
    func popToViewController(ofClass: AnyClass, animated: Bool = true) {
        if let vc = viewControllers.last(where: { $0.isKind(of: ofClass) }) {
            popToViewController(vc, animated: animated)
        }
    }
}
