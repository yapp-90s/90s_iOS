//
//  AlbumCover.swift
//  90s
//
//  Created by 김진우 on 2020/12/30.
//

import UIKit

struct AlbumCover: Codable {
    var uid: Int
    var name: String
    var fileName: String
//    var mainColor: UIColor? = nil
//    var subColor: UIColor? = nil
}

extension AlbumCover {
    static var empty: AlbumCover {
        .init(uid: 0, name: "AlbumSweetLittleMemories", fileName: "")
    }
    
    var image: UIImage {
        return UIImage(named: fileName) ?? .add
    }
    
    
}

extension AlbumCover {
    static let sweetLittleMemories: AlbumCover = .init(uid: 0, name: "Sweet Little Memories", fileName: "AlbumSweetLittleMemories")
    static let youMakeMeCloudy: AlbumCover = .init(uid: 1, name: "You Make Me Cloudy", fileName: "AlbumYouMakeMeCloudy")
    static let stickyBubble: AlbumCover = .init(uid: 2, name: "Sticky Bubble", fileName: "AlbumStickyBubble")
    static let candy: AlbumCover = .init(uid: 3, name: "Candy", fileName: "AlbumCandy")
    static let yic: AlbumCover = .init(uid: 4, name: "YIC", fileName: "AlbumYIC")
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
