//
//  Typography.swift
//  90s
//
//  Created by 김진우 on 2021/01/16.
//

import UIKit
import Foundation

extension UIFont {
    static var Head = UIFont.boldSystemFont(ofSize: 21) 
    static let Large_Text = UIFont.systemFont(ofSize: 20, weight: .regular)
    static let Large_Text_Bold = UIFont.boldSystemFont(ofSize: 20)
    
    static let Sub_Head = UIFont.systemFont(ofSize: 17, weight: .regular)
    static let Popup_Title = UIFont.boldSystemFont(ofSize: 17)
    static let Film_Title = UIFont.boldSystemFont(ofSize: 16)
    static let Top_Title = UIFont.systemFont(ofSize: 15, weight: .regular)
    
    static let Profile_Menu_Text = UIFont.systemFont(ofSize: 15, weight: .regular)
    static let Btn_Text = UIFont.boldSystemFont(ofSize: 15)
    static let Input_Text = UIFont.boldSystemFont(ofSize: 15)
    
    static let Medium_Text = UIFont.systemFont(ofSize: 14, weight: .regular)
    static let Medium_Text_Bold = UIFont.boldSystemFont(ofSize: 14)
    
    static let Btn_Small_Text = UIFont.boldSystemFont(ofSize: 13)
    static let Film_Sub_Title = UIFont.systemFont(ofSize: 13, weight: .regular)
    
    static let Small_Text = UIFont.systemFont(ofSize: 12, weight: .regular)
    static let Small_Text_Bold = UIFont.boldSystemFont(ofSize: 12)
}

extension UIFont {
    static var head = UIFont.boldSystemFont(ofSize: 21 * layoutScale)
    static let largeText = UIFont.systemFont(ofSize: 20 * layoutScale, weight: .regular)
    static let largeTextBold = UIFont.boldSystemFont(ofSize: 20 * layoutScale)
    
    static let subHead = UIFont.systemFont(ofSize: 17 * layoutScale, weight: .regular)
    static let popupTitle = UIFont.boldSystemFont(ofSize: 17 * layoutScale)
    static let filmTitle = UIFont.boldSystemFont(ofSize: 16 * layoutScale)
    static let topTitle = UIFont.systemFont(ofSize: 15 * layoutScale, weight: .regular)
    
    static let profileMenuText = UIFont.systemFont(ofSize: 15 * layoutScale, weight: .regular)
    static let buttonText = UIFont.boldSystemFont(ofSize: 15 * layoutScale)
    static let inputText = UIFont.boldSystemFont(ofSize: 15 * layoutScale)
    
    static let mediumText = UIFont.systemFont(ofSize: 14 * layoutScale, weight: .regular)
    static let mediumTextBold = UIFont.boldSystemFont(ofSize: 14 * layoutScale)
    
    static let buttomSmallText = UIFont.boldSystemFont(ofSize: 13 * layoutScale)
    static let filmSubTitle = UIFont.systemFont(ofSize: 13 * layoutScale, weight: .regular)
    
    static let smallText = UIFont.systemFont(ofSize: 12 * layoutScale, weight: .regular)
    static let smallTextBold = UIFont.boldSystemFont(ofSize: 12 * layoutScale)
}
