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
                StickerPack(name: "이름이름이름이름이름이름이름이름이름이름이름이름", thumbnailImageName: "film_default", stickers: [], category: .basic),
                StickerPack(name: "이름이름", thumbnailImageName: "film_default", stickers: [], category: .basic),
                StickerPack(name: "아름아름", thumbnailImageName: "film_default", stickers: [], category: .basic)
            ]
            case .brink: return [
                StickerPack(name: "설날22", thumbnailImageName: "film_default", stickers: [], category: .basic),
                StickerPack(name: "이름", thumbnailImageName: "film_default", stickers: [], category: .basic),
                StickerPack(name: "이름이름", thumbnailImageName: "film_default", stickers: [], category: .basic),
                StickerPack(name: "아름아름", thumbnailImageName: "film_default", stickers: [], category: .basic)
            ]
            case .dark: return [
                StickerPack(name: "설날33", thumbnailImageName: "film_default", stickers: [], category: .basic),
                StickerPack(name: "이름이름이름이름이름이름이름이름이름이름이름이름", thumbnailImageName: "film_default", stickers: [], category: .basic),
                StickerPack(name: "이름이름", thumbnailImageName: "film_default", stickers: [], category: .basic),
                StickerPack(name: "아름아름", thumbnailImageName: "film_default", stickers: [], category: .basic),
                StickerPack(name: "이름이름", thumbnailImageName: "film_default", stickers: [], category: .basic),
                StickerPack(name: "아름아름", thumbnailImageName: "film_default", stickers: [], category: .basic)
            ]
            case .cuty: return [
                StickerPack(name: "설날44", thumbnailImageName: "film_default", stickers: [], category: .basic),
                StickerPack(name: "이름이름이름이름", thumbnailImageName: "film_default", stickers: [], category: .basic),
                StickerPack(name: "이름이름", thumbnailImageName: "film_default", stickers: [], category: .basic),
                StickerPack(name: "아름아름", thumbnailImageName: "film_default", stickers: [], category: .basic),
                StickerPack(name: "이름이름", thumbnailImageName: "film_default", stickers: [], category: .basic),
                StickerPack(name: "아름아름", thumbnailImageName: "film_default", stickers: [], category: .basic)
            ]
        }
    }
}
