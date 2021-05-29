//
//  UILabel+.swift
//  90s
//
//  Created by 성다연 on 2021/04/22.
//

import Foundation
import UIKit


extension UILabel {
    class func createSpacingLabel(text: String, size: CGFloat = 17, numberOfLines: Int = 2) -> UILabel {
        let label = UILabel(frame: .zero)
        let style = NSMutableParagraphStyle()
        style.lineSpacing = 5
        let attributes : [NSAttributedString.Key : Any] = [ .paragraphStyle : style ]
        let attrString = NSAttributedString(string: text, attributes: attributes)
        label.font = label.font.withSize(size)
        label.attributedText = attrString
        label.numberOfLines = numberOfLines
        
        return label
    }
    
    class func createNormalBoldLabel(normal text1 : String, bold text2: String, size: CGFloat = 12) -> UILabel {
        let label = UILabel(frame: .zero)
        let normalAttribute : [NSAttributedString.Key : Any] = [.font : UIFont.systemFont(ofSize: size)]
        let boldAttribute : [NSAttributedString.Key : Any] = [.font :UIFont.boldSystemFont(ofSize: size)]
        var whiteSpace = " "
        for _ in 0..<(8 - text1.count) {
            whiteSpace.append("  ")
        }
        
        let attribute = NSMutableAttributedString()
            .attatch(attr: NSMutableAttributedString(string: text1 + whiteSpace, attributes: normalAttribute))
            .attatch(attr: NSMutableAttributedString(string: text2, attributes: boldAttribute))
        label.attributedText = attribute
        
        return label
    }
}


extension NSMutableAttributedString {
    func attatch(attr : NSMutableAttributedString) -> NSMutableAttributedString {
        self.append(attr)
        return self
    }
}
