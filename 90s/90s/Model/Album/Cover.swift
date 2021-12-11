//
//  AlbumCover.swift
//  90s
//
//  Created by 김진우 on 2020/12/30.
//

import UIKit

struct Cover {
//    private static let all: [Cover] = [.sweetLittleMemories, .youMakeMeCloudy, .stickyBubble, .candy, .yic]
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
//    static var random: Cover {
//        let list = [sweetLittleMemories, youMakeMeCloudy, stickyBubble, candy, yic]
//        return list.randomElement() ?? .yic
//    }
//
    static let sweetLittleMemories: Cover = .init(code: 1001, name: "Sweet Little Memories", fileName: "AlbumSweetLittleMemories")
    static let youMakeMeCloudy: Cover = .init(code: 1002, name: "You Make Me Cloudy", fileName: "AlbumYouMakeMeCloudy")
    static let stickyBubble: Cover = .init(code: 1003, name: "Sticky Bubble", fileName: "AlbumStickyBubble")
    static let candy: Cover = .init(code: 1004, name: "Candy", fileName: "AlbumCandy")
    static let yic: Cover = .init(code: 1005, name: "YIC", fileName: "AlbumYIC")
}
//extension AlbumCover {
//    static let copy: AlbumCover = .init(uid: 0, name: "1990 Copy", path: "albumcover1990Copy.png")
//    static let paradiso: AlbumCover = .init(uid: 1, name: "Paradiso", path: "albumcoverParadiso.png")
//    static let happilyEverAfter: AlbumCover = .init(uid: 2, name: "Happily Ever After", path: "albumcoverHappilyeverafter.png")
//    static let favoriteThings: AlbumCover = .init(uid: 3, name: "Favorite Things", path: "albumcoverFavoritethings.png")
//    static let awesomeMix: AlbumCover = .init(uid: 4, name: "Awesome Mix", path: "albumcoverAwsomemix")
//    static let lessButBetter: AlbumCover = .init(uid: 5, name: "Less But Better", path: "albumcoverLessbutbetter.png")
//    static let sretroClub: AlbumCover = .init(uid: 6, name: "Sretro Club", path: "albumcover90Sretroclub.png")
//    static let oneAndOnlyCopy: AlbumCover = .init(uid: 7, name: "One & Only Copy", path: "albumcoverOneandonlyCopy")
//}
