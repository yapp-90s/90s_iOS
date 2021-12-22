//
//  BaseViewController.swift
//  90s
//
//  Created by woong on 2021/03/06.
//

import UIKit
import RxSwift

class BaseViewController: UIViewController {
    
    typealias BarButtonType = BaseNavigationControllerViewController.BarButtonType
    typealias BarButtonPosition = BaseNavigationControllerViewController.BarButtonPosition
    
    var disposeBag = DisposeBag()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .systemBackground
        navigationItem.backBarButtonItem = UIBarButtonItem(title: "", style: .plain, target: nil, action: nil)
    }
    
    deinit {
        #if DEBUG
        print("deinit: \(self)")
        #endif
    }
    
    func setBarButtonItem(type: BarButtonType, position: BarButtonPosition, action: Selector? = nil) {
        
        var barButtonItem: UIBarButtonItem?
        switch type {
            case .textCancle:
                barButtonItem = UIBarButtonItem(title: "취소", style: .plain, target: self, action: action)
                barButtonItem?.setTitleTextAttributes([
                    .font: UIFont.boldSystemFont(ofSize: 16)
                ], for: .normal)
            case .textEdit:
                barButtonItem = UIBarButtonItem(title: "편집", style: .plain, target: self, action: action)
                barButtonItem?.setTitleTextAttributes([
                    .font: UIFont.boldSystemFont(ofSize: 16)
                ], for: .normal)
            case .imgClose:
                barButtonItem = UIBarButtonItem(image: UIImage(named: "navigationBar_close"), style: .plain, target: self, action: action)
            case .imgCheck:
                barButtonItem = UIBarButtonItem(image: UIImage(named: "navigationBar_check")?.withRenderingMode(.alwaysOriginal), style: .plain, target: self, action: action)
            case .imgBack:
                barButtonItem = UIBarButtonItem(image: .init(named: "navigationBar_back")?.withRenderingMode(.alwaysOriginal), style: .plain, target: self, action: action)
        }
        
        if position == .left {
            navigationItem.leftBarButtonItem = barButtonItem
        } else {
            navigationItem.rightBarButtonItem = barButtonItem
        }
    }
    
    func removeRightBarButtonItem(position: BarButtonPosition) {
        if position == .left {
            navigationItem.leftBarButtonItem = nil
        } else {
            navigationItem.rightBarButtonItem = nil
        }
    }
}
