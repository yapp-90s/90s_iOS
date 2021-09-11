//
//  StickerFactory.swift
//  90s
//
//  Created by woong on 2021/03/06.
//

import Foundation

struct StickerFactory {
    func stickerPackList(of category: StickerPackCategory) -> [StickerPackType] {
        switch category {
            case .basic: return [
                DrawingStickerPack(),
                GeometricStickerPack(),
                RibbonStickerPack(),
                TapeStickerPack()
            ]
            case .charactersAndNumbers: return []
            case .season: return []
            case .trip: return []
        }
    }
}
