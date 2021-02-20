//
//  StickerPackCategory.swift
//  90s
//
//  Created by woong on 2021/02/20.
//

import Foundation

enum StickerPackCategory: CaseIterable {
    case basic
    case brink
    case dark
    case cuty
}

extension StickerPackCategory: CustomStringConvertible {
    var description: String {
        switch self {
            case .basic: return "기본기본"
            case .brink: return "화려화려"
            case .dark: return "다크다크"
            case .cuty: return "귀염귀염"
        }
    }
}
