//
//  Color.swift
//  90s
//
//  Created by 김진우 on 2021/01/16.
//

import UIKit
import Foundation

//enum Color {
//    static let retroOrange = UIColor.colorRGBHex(hex: 0xF65D48)
//}
extension UIColor {
    static let retroOrange = ColorType.Retro_Orange.create()
    static let retroBlack = ColorType.Retro_Black.create()
    static let retroLightgray = ColorType.Retro_Lightgray.create()
    static let retroGray = ColorType.Retro_Gray.create()
    static let Warm_Lightgray = ColorType.Warm_Lightgray.create()
    static let Warm_Gray = ColorType.Warm_Gray.create()
}

enum ColorType {
    case Retro_Orange
    case Retro_Black
    case Retro_Lightgray
    case Retro_Gray
    case Warm_Lightgray
    case Warm_Gray
    
    func create() -> UIColor {
        switch self {
        case .Retro_Orange:
            return UIColor.colorRGBHex(hex: 0xF65D48)
        case .Retro_Black:
            return UIColor.colorRGBHex(hex: 0x18171D)
        case .Retro_Lightgray:
            return UIColor.colorRGBHex(hex: 0xBEBEBE)
        case .Retro_Gray:
            return UIColor.colorRGBHex(hex: 0x9D9D9D)
        case .Warm_Lightgray:
            return UIColor.colorRGBHex(hex: 0x575252)
        case .Warm_Gray:
            return UIColor.colorRGBHex(hex: 0x363333)
        }
    }
}
