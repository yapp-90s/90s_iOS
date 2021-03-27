//
//  Color.swift
//  90s
//
//  Created by 김진우 on 2021/01/16.
//

import UIKit
import Foundation

enum Color {
//    static let 
}


enum ColorType {
    case retro_Orange
    case retro_Black
    case retro_Lightgray
    case retro_Gray
    case warm_Lightgray
    case warm_Gray
    
    func create() -> UIColor {
        switch self {
        case .retro_Orange:
            return UIColor.colorRGBHex(hex: 0xF65D48)
        case .retro_Black:
            return UIColor.colorRGBHex(hex: 0x18171D)
        case .retro_Lightgray:
            return UIColor.colorRGBHex(hex: 0xBEBEBE)
        case .retro_Gray:
            return UIColor.colorRGBHex(hex: 0x9D9D9D)
        case .warm_Lightgray:
            return UIColor.colorRGBHex(hex: 0x575252)
        case .warm_Gray:
            return UIColor.colorRGBHex(hex: 0x363333)
        }
    }
}
