//
//  NavigationBar.swift
//  90s
//
//  Created by 성다연 on 2021/03/16.
//

import Foundation
import UIKit

enum NavBarRightBtn {
    case textCancle
    case textEdit
    case imgClose
    case imgCheck
}

extension UIButton {
    func setUpNavBarRightBtn(type: NavBarRightBtn){
        switch type {
        case .textCancle:
            setTitleColor( .white, for: .normal)
            titleLabel?.font = .boldSystemFont(ofSize: 16)
            contentEdgeInsets = UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 5)
            setTitle("취소", for: .normal)
        case .textEdit:
            setTitleColor( .white, for: .normal)
            titleLabel?.font = .boldSystemFont(ofSize: 16)
            contentEdgeInsets = UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 5)
            setTitle("편집", for: .normal)
        case .imgClose:
            setImage(UIImage(named: "navigationBar_close"), for: .normal)
        case .imgCheck:
            setImage(UIImage(named: "navigationBar_check"), for: .normal)
        }
    }
}
