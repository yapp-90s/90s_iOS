//
//  Color.swift
//  90s
//
//  Created by 김진우 on 2021/01/16.
//

import UIKit

extension UIColor {
    class var retroOrange: UIColor { return UIColor(named: "retro_orange")! }
    class var retroBlack: UIColor { return UIColor(named: "retro_black")! }
    class var retroLightgray: UIColor { return UIColor(named: "retro_lightgray")! }
    class var retroGray: UIColor { return UIColor(named: "retro_gray")! }
    class var warmLightgray: UIColor { return UIColor(named: "warm_lightgray")! }
    class var warmGray: UIColor { return UIColor(named: "warm_gray")! }
}

extension UIColor {
    class func colorRGBHex(hex:Int, alpha: Float = 1.0) -> UIColor {
        let r = Float((hex >> 16) & 0xFF)
        let g = Float((hex >> 8) & 0xFF)
        let b = Float((hex) & 0xFF)
        return UIColor(red: CGFloat(r/255.0), green: CGFloat(g/255.0), blue:CGFloat(b/255.0), alpha : CGFloat(alpha))
    }
}
