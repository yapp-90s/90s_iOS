//
//  StickerFactory.swift
//  90s
//
//  Created by woong on 2021/03/06.
//

import Foundation

struct StickerFactory {
    func stickerPackList(of category: StickerPackCategory) -> [StickerPack] {
        switch category {
            case .basic: return [
                StickerPack(name: "설날",
                            thumbnailImageName: "film_default",
                            stickers: (0...10).map { _ in Sticker(imageName: "film_default") },
                            category: .basic),
            ]
            case .charactersAndNumbers: return []
            case .season: return []
            case .trip: return []
        }
    }
}
