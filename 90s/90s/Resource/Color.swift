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
    static let Cool_Lightgray = ColorType.Cool_Lightgray.create()
    static let Cool_Gray = ColorType.Cool_Gray.create()
}

enum ColorType {
    case Retro_Orange
    case Retro_Black
    case Retro_Lightgray
    case Retro_Gray
    case Warm_Lightgray
    case Warm_Gray
    case Cool_Lightgray
    case Cool_Gray
    
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
        case .Cool_Lightgray:
            return UIColor.colorRGBHex(hex: 0x43454D)
        case .Cool_Gray:
            return UIColor.colorRGBHex(hex: 0x2E2F33)
        }
    }
}

extension UIColor {
    
    convenience init(hexString: String) {
        let hex = hexString.trimmingCharacters(in: CharacterSet.alphanumerics.inverted)
        var int = UInt64()
        Scanner(string: hex).scanHexInt64(&int)
        let a, r, g, b: UInt64
        switch hex.count {
        case 3: // RGB (12-bit)
            (a, r, g, b) = (255, (int >> 8) * 17, (int >> 4 & 0xF) * 17, (int & 0xF) * 17)
        case 6: // RGB (24-bit)
            (a, r, g, b) = (255, int >> 16, int >> 8 & 0xFF, int & 0xFF)
        case 8: // ARGB (32-bit)
            (a, r, g, b) = (int >> 24, int >> 16 & 0xFF, int >> 8 & 0xFF, int & 0xFF)
        default:
            (a, r, g, b) = (255, 0, 0, 0)
        }
        self.init(red: CGFloat(r) / 255, green: CGFloat(g) / 255, blue: CGFloat(b) / 255, alpha: CGFloat(a) / 255)
    }
}
