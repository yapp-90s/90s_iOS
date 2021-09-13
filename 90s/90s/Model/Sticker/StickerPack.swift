//
//  StickerPack.swift
//  90s
//
//  Created by 김진우 on 2021/02/06.
//

import Foundation

protocol StickerPackType {
    var name: String { get }
    var thumbnailImageName: String { get }
    var stickers: [Sticker] { get }
}

// MARK: - Basic
struct DrawingStickerPack: StickerPackType {
    let name = "드로잉"
    let thumbnailImageName = "Sticker_Thumb_Drawing"
    let stickers: [Sticker] = (1...10).map { Sticker(imageName: "Sticker_Drawing\($0)") }
}

struct GeometricStickerPack: StickerPackType {
    let name = "지오메트릭"
    let thumbnailImageName = "Sticker_Thumb_Geometric"
    let stickers: [Sticker] = (1...10).map { Sticker(imageName: "Sticker_Geometric\($0)") }
}

struct RibbonStickerPack: StickerPackType {
    let name = "리본"
    let thumbnailImageName = "Sticker_Thumb_Ribbon"
    let stickers: [Sticker] = (1...10).map { Sticker(imageName: "Sticker_Ribbon\($0)") }
}

struct TapeStickerPack: StickerPackType {
    let name = "테이프"
    let thumbnailImageName = "Sticker_Thumb_Tape"
    let stickers: [Sticker] = (1...10).map { Sticker(imageName: "Sticker_Tape\($0)") }
}
