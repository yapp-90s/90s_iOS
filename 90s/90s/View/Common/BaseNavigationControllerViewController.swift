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
        case imgBack
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        navigationBar.tintColor = .white
        let backButtonBackgroundImage = UIImage(named: "navigationBar_back")!
        navigationBar.backIndicatorImage = backButtonBackgroundImage
        navigationBar.backIndicatorTransitionMaskImage = backButtonBackgroundImage
        UIBarButtonItem.appearance().setBackButtonTitlePositionAdjustment(UIOffset(horizontal: 5, vertical: -6), for: .default)
        
        navigationBar.backgroundColor = .clear
        navigationBar.setBackgroundImage(UIImage(), for: .default)
        navigationBar.shadowImage = UIImage()
        view.backgroundColor = .clear
    }
    
    @objc func tappedBackButtonItem() {
        navigationController?.popViewController(animated: true)
    }
}
