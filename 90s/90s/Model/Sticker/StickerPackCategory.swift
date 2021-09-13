//
//  StickerPackCategory.swift
//  90s
//
//  Created by woong on 2021/02/20.
//

import Foundation

enum StickerPackCategory: CaseIterable {
    case basic
    case charactersAndNumbers
    case season
    case trip
}

extension StickerPackCategory: CustomStringConvertible {
    var description: String {
        switch self {
            case .basic: return "베이직"
            case .charactersAndNumbers: return "문자&숫자"
            case .season: return "계절"
            case .trip: return "여행"
        }
    }
}
