//
//  Typography.swift
//  90s
//
//  Created by 김진우 on 2021/01/16.
//

import UIKit
import Foundation

enum Typography {
//    static let 
}


enum LabelType {
    case bold_21
    case bold_16
    case bold_18
    case normal_21
    case normal_16
    case normal_gray_16
    case normal_gray_13
    
    func create() -> UILabel {
        let label = UILabel(frame: .zero)
//        label.textColor = white ? .black : .white
        
        switch self {
        case .bold_21:
            label.font = UIFont.boldSystemFont(ofSize: 21)
        case .bold_16:
            label.font = UIFont.boldSystemFont(ofSize: 16)
        case .bold_18:
            label.font = UIFont.boldSystemFont(ofSize: 18)
        case .normal_21:
            label.font = label.font.withSize(21)
        case .normal_16:
            label.font = label.font.withSize(16)
        case .normal_gray_16:
            label.font = label.font.withSize(16)
            label.textColor = .gray
        case .normal_gray_13:
            label.font = label.font.withSize(13)
            label.textColor = .gray
        }
        return label
    }
}
