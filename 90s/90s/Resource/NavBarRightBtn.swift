//
//  NavigationBar.swift
//  90s
//
//  Created by 성다연 on 2021/03/16.
//

import Foundation
import UIKit

enum NavBarRightBtn {
    case text_cancle
    case text_edit
    case img_close
    case img_check
}

extension UIButton {
    func setUpNavBarRightBtn(type: NavBarRightBtn){
        switch type {
        case .text_cancle:
            setTitleColor( .black, for: .normal)
            titleLabel?.font = .boldSystemFont(ofSize: 16)
            contentEdgeInsets = UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 5)
            setTitle("취소", for: .normal)
        case .text_edit:
            setTitleColor( .black, for: .normal)
            titleLabel?.font = .boldSystemFont(ofSize: 16)
            contentEdgeInsets = UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 5)
            setTitle("편집", for: .normal)
        case .img_close:
            setImage(UIImage(named: "navigationBar_close"), for: .normal)
        case .img_check:
            setImage(UIImage(named: "navigationBar_check"), for: .normal)
        }
    }
}
