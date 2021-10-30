//
//  AlbumCover.swift
//  90s
//
//  Created by 김진우 on 2020/12/30.
//

import UIKit

struct AlbumCover: Codable {
    var uid: Int
//    var code: Int
    var name: String
//    var description: String?
//    var createdAt: String
//    var releasedAt: String?
    var path: String
}

extension AlbumCover {
    static var empty: AlbumCover {
        .init(uid: 0, name: "AlbumSweetLittleMemories", path: "")
//        .init(uid: 0, code: 0, name: "", description: nil, createdAt: "", releasedAt: nil, path: "")
    }
    var image: UIImage {
        return UIImage(named: name) ?? .add
    }
}
