//
//  AlbumCover.swift
//  90s
//
//  Created by 김진우 on 2020/12/30.
//

import UIKit

struct AlbumCover: Codable {
    var uid: Int
    var code: Int
    var name: String
    var description: String?
    var createdAt: String
    var releasedAt: String?
    var path: String
}

extension AlbumCover {
    var image: UIImage {
        return UIImage(named: path)!
    }
}

//
//struct Copy: AlbumCover {
//    let name = "1990 Copy"
//    let imageName = "albumcover1990Copy"
//}
//
//struct Paradiso: AlbumCover {
//    let name = "Paradiso"
//    let imageName = "albumcoverParadiso"
//}
//
//struct HappilyEverAfter: AlbumCover {
//    let name = "Happily Ever After"
//    let imageName = "albumcoverHappilyeverafter"
//}
//
//struct FavoriteThings: AlbumCover {
//    let name = "Favorite Things"
//    let imageName = "albumcoverFavoritethings"
//}
//
//struct AwesomeMix: AlbumCover {
//    let name = "Awesome Mix"
//    let imageName = "albumcoverAwsomemix"
//}
//
//struct LessButBetter: AlbumCover {
//    let name = "Less But Better"
//    let imageName = "albumcoverLessbutbetter"
//}
//
//struct SretroClub: AlbumCover {
//    let name = "Sretro Club"
//    let imageName = "albumcover90Sretroclub"
//}
//
//struct OneAndOnlyCopy: AlbumCover {
//    let name = "One & Only Copy"
//    let imageName = "albumcoverOneandonlyCopy"
//}
