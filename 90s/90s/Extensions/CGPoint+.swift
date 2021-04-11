//
//  CGPoint+.swift
//  90s
//
//  Created by woong on 2021/04/10.
//

import UIKit

extension CGPoint {
    func distance(to point: CGPoint) -> CGFloat {
        let distX = x - point.x
        let distY = y - point.y
        return (distX * distX + distY * distY).squareRoot()
    }
    
    func absoulteAngle(to point: CGPoint) -> CGFloat {
        return atan2(y - point.y, x - point.x)
    }
}
