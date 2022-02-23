//
//  AlbumCover.swift
//  90s
//
//  Created by 김진우 on 2020/12/30.
//

import UIKit

struct Cover {
    var code: Int
    var name: String
    var fileName: String
//    var mainColor: UIColor? = nil
//    var subColor: UIColor? = nil
}

extension Cover {
    var image: UIImage {
        return UIImage(named: fileName) ?? .add
    }
}

extension Cover {
    static let sweetLittleMemories: Cover = .init(code: 1001, name: "Sweet Little Memories", fileName: "AlbumSweetLittleMemories")
    static let youMakeMeCloudy: Cover = .init(code: 1002, name: "You Make Me Cloudy", fileName: "AlbumYouMakeMeCloudy")
    static let stickyBubble: Cover = .init(code: 1003, name: "Sticky Bubble", fileName: "AlbumStickyBubble")
    static let candy: Cover = .init(code: 1004, name: "Candy", fileName: "AlbumCandy")
    static let yic: Cover = .init(code: 1005, name: "YIC", fileName: "AlbumYIC")
}
