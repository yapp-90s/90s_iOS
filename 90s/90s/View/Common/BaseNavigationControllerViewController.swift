//
//  BaseNavigationControllerViewController.swift
//  90s
//
//  Created by woong on 2021/03/27.
//

import UIKit

class BaseNavigationControllerViewController: UINavigationController {
    
    enum BarButtonPosition {
        case left
        case right
    }
    
    enum BarButtonType {
        case textCancle
        case textEdit
        case imgClose
        case imgCheck
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        navigationBar.tintColor = .white
        let backButtonBackgroundImage = UIImage(named: "navigate_back")!
        navigationBar.backIndicatorImage = backButtonBackgroundImage
        navigationBar.backIndicatorTransitionMaskImage = backButtonBackgroundImage
        UIBarButtonItem.appearance().setBackButtonTitlePositionAdjustment(UIOffset(horizontal: 5, vertical: -6), for: .default)
    }
    
    @objc func tappedBackButtonItem() {
        navigationController?.popViewController(animated: true)
    }
}
