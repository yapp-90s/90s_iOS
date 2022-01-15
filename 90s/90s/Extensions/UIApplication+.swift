//
//  UIApplication+.swift
//  90s
//
//  Created by woongs on 2022/01/01.
//

import UIKit

extension UIApplication {
    
    var topViewController: UIViewController? {
        let windowScene = self.connectedScenes.first as? UIWindowScene
        return windowScene?.windows.first?.rootViewController
    }
}
