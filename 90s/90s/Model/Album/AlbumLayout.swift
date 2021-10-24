//
//  AlbumLayout.swift
//  90s
//
//  Created by 김진우 on 2020/12/30.
//

import UIKit

/*
protocol AlbumLayout {
    var imageName: String { get }
    var layoutUid: Int { get }
    var layoutName: String { get }
    var size: CGSize { get }
    var deviceLowSize: CGSize { get }
    var innerFrameLowSize: CGSize { get }
    var deviceHighSize: CGSize { get }
    var innerFrameHighSize: CGSize { get }
    var dateLabelFrame: CGSize { get }
    var cropImageName: String { get }
}

extension AlbumLayout {
    var image: UIImage {
        return UIImage(named: imageName)!
    }
    
    var cropImage: UIImage {
        return UIImage(named: cropImageName)!
    }
}

struct Pelaroid: AlbumLayout {
    let imageName = "framePolaroid"
    let layoutUid = 0
    let layoutName = "Polaroid"
    let size = CGSize(width: 184, height: 213)
    let deviceLowSize = CGSize(width: 290, height: 332)
    let deviceHighSize = CGSize(width: 338, height: 463)
    let innerFrameLowSize = CGSize(width: 263, height: 257)
    let innerFrameHighSize = CGSize(width: 314, height: 306)
    let dateLabelFrame = CGSize(width: 40, height: 90)
    let cropImageName = "cropPolaroid"
}

struct Mini: AlbumLayout {
    let imageName = "frameMini"
    let layoutUid = 1
    let layoutName = "Mini"
    let size = CGSize(width: 183, height: 249)
    let deviceLowSize = CGSize(width: 259, height: 354)
    let deviceHighSize = CGSize(width: 338, height: 463)
    let innerFrameLowSize = CGSize(width: 228, height: 286)
    let innerFrameHighSize = CGSize(width: 302, height: 380)
    let dateLabelFrame = CGSize(width: 34, height: 85)
    let cropImageName = "cropMini"
}

struct Memory: AlbumLayout {
    let imageName = "frameMemory"
    let layoutUid = 2
    let layoutName = "Memory"
    let size = CGSize(width: 261, height: 236)
    let deviceLowSize = CGSize(width: 311, height: 281)
    let deviceHighSize = CGSize(width: 354, height: 320)
    let innerFrameLowSize = CGSize(width: 265, height: 227)
    let innerFrameHighSize = CGSize(width: 302, height: 260)
    let dateLabelFrame = CGSize(width: 44, height: 44)
    let cropImageName = "cropMemory"
}

struct Portrab: AlbumLayout {
    let imageName = "framePortrab"
    let layoutUid = 3
    let layoutName = "Portrab"
    let size = CGSize(width: 270, height: 325)
    let deviceLowSize = CGSize(width: 291, height: 348)
    let deviceHighSize = CGSize(width: 346, height: 414)
    let innerFrameLowSize = CGSize(width: 275, height: 332)
    let innerFrameHighSize = CGSize(width: 326, height: 392)
    let dateLabelFrame = CGSize(width: 32, height: 25)
    let cropImageName = "cropPortrab"
}

struct Tape: AlbumLayout {
    let imageName = "frameTape"
    let layoutUid = 4
    let layoutName = "Tape"
    let size = CGSize(width: 326, height: 336)
    let deviceLowSize = CGSize(width: 294, height: 304)
    let deviceHighSize = CGSize(width: 354, height: 366)
    let innerFrameLowSize = CGSize(width: 294, height: 304)
    let innerFrameHighSize = CGSize(width: 316, height: 258)
    let dateLabelFrame = CGSize(width: 33, height: 81)
    let cropImageName = "cropTape"
}

struct Portraw: AlbumLayout {
    let imageName = "framePortraw"
    let layoutUid = 5
    let layoutName = "Portraw"
    let size = CGSize(width: 356, height: 218)
    let deviceLowSize = CGSize(width: 330, height: 202)
    let deviceHighSize = CGSize(width: 361, height: 221)
    let innerFrameLowSize = CGSize(width: 324, height: 184)
    let innerFrameHighSize = CGSize(width: 352, height: 200)
    let dateLabelFrame = CGSize(width: 16, height: 22)
    let cropImageName = "cropPortraw"
}

struct Filmroll: AlbumLayout {
    let imageName = "frameFilmroll"
    let layoutUid = 6
    let layoutName = "Filrmroll"
    let size = CGSize(width: 286, height: 382)
    let deviceLowSize = CGSize(width: 267, height: 357)
    let deviceHighSize = CGSize(width: 332, height: 444)
    let innerFrameLowSize = CGSize(width: 208, height: 354)
    let innerFrameHighSize = CGSize(width: 258, height: 440)
    let dateLabelFrame = CGSize(width: 50, height: 16)
    let cropImageName = "cropFilmroll"
}
*/

// ------------------

//enum AlbumLayouts {
//    // sticker
//    var deviceHighSize : CGSize{
//        switch self {
//        case .Portraw : return CGSize(width: 361, height: 221)
//        case .Filmroll : return CGSize(width: 332, height: 444)
//        }
//    }
//
//    var innerFrameHighSize : CGSize {
//        switch self {
//        case .Tape: return CGSize(width: 316, height: 258)
//        case .Portraw: return CGSize(width: 352, height: 200)
//        case .Filmroll: return CGSize(width: 258, height: 440)
//        }
//    }
//}
