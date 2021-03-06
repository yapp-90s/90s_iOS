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
                            thumbnailImageName: "filmimg",
                            stickers: (0...10).map { _ in Sticker(imageName: "filmimg") },
                            category: .basic),
                StickerPack(name: "이름이름이름이름이름이름이름이름이름이름이름이름", thumbnailImageName: "filmimg", stickers: [], category: .basic),
                StickerPack(name: "이름이름", thumbnailImageName: "filmimg", stickers: [], category: .basic),
                StickerPack(name: "아름아름", thumbnailImageName: "filmimg", stickers: [], category: .basic)
            ]
            case .brink: return [
                StickerPack(name: "설날22", thumbnailImageName: "filmimg", stickers: [], category: .basic),
                StickerPack(name: "이름", thumbnailImageName: "filmimg", stickers: [], category: .basic),
                StickerPack(name: "이름이름", thumbnailImageName: "filmimg", stickers: [], category: .basic),
                StickerPack(name: "아름아름", thumbnailImageName: "filmimg", stickers: [], category: .basic)
            ]
            case .dark: return [
                StickerPack(name: "설날33", thumbnailImageName: "filmimg", stickers: [], category: .basic),
                StickerPack(name: "이름이름이름이름이름이름이름이름이름이름이름이름", thumbnailImageName: "filmimg", stickers: [], category: .basic),
                StickerPack(name: "이름이름", thumbnailImageName: "filmimg", stickers: [], category: .basic),
                StickerPack(name: "아름아름", thumbnailImageName: "filmimg", stickers: [], category: .basic),
                StickerPack(name: "이름이름", thumbnailImageName: "filmimg", stickers: [], category: .basic),
                StickerPack(name: "아름아름", thumbnailImageName: "filmimg", stickers: [], category: .basic)
            ]
            case .cuty: return [
                StickerPack(name: "설날44", thumbnailImageName: "filmimg", stickers: [], category: .basic),
                StickerPack(name: "이름이름이름이름", thumbnailImageName: "filmimg", stickers: [], category: .basic),
                StickerPack(name: "이름이름", thumbnailImageName: "filmimg", stickers: [], category: .basic),
                StickerPack(name: "아름아름", thumbnailImageName: "filmimg", stickers: [], category: .basic),
                StickerPack(name: "이름이름", thumbnailImageName: "filmimg", stickers: [], category: .basic),
                StickerPack(name: "아름아름", thumbnailImageName: "filmimg", stickers: [], category: .basic)
            ]
        }
    }
}
