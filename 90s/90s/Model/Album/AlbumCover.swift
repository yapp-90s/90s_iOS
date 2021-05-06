//
//  AlbumCover.swift
//  90s
//
//  Created by 김진우 on 2020/12/30.
//

import UIKit

protocol AlbumCover {
    var name: String { get }
    var imageName: String { get }
}

extension AlbumCover {
    var image: UIImage {
        return UIImage(named: imageName) ?? UIImage()
    }
}

struct Copy: AlbumCover {
    let name = "1990 Copy"
    let imageName = "albumcover1990Copy.png"
}

struct Paradiso: AlbumCover {
    let name = "Paradiso"
    let imageName = "albumcoverParadiso.png"
}

struct HappilyEverAfter: AlbumCover {
    let name = "Happily Ever After"
    let imageName = "albumcoverHappilyeverafter.png"
}

struct FavoriteThings: AlbumCover {
    let name = "Favorite Things"
    let imageName = "albumcoverFavoritethings"
}

struct AwesomeMix: AlbumCover {
    let name = "Awesome Mix"
    let imageName = "albumcoverAwsomemix"
}

struct LessButBetter: AlbumCover {
    let name = "Less But Better"
    let imageName = "albumcoverLessbutbetter"
}

struct SretroClub: AlbumCover {
    let name = "Sretro Club"
    let imageName = "albumcover90Sretroclub"
}

struct OneAndOnlyCopy: AlbumCover {
    let name = "One & Only Copy"
    let imageName = "albumcoverOneandonlyCopy"
}
