//
//  Album.swift
//  90s
//
//  Created by 김진우 on 2020/12/27.
//

import UIKit

struct Album: Codable {
    let uid: String
    var user: [String]? = []
    let name: String
    var createdAt: String
    var updatedAt: String
    var completedAt: String?
    let totalPaper: Int
    let cover: AlbumCover
    private(set) var photos: [Photo] = []
    
//    enum CodingKeys: String, CodingKey {
//        case cover = "albumCover"
//        case
//    }
}

extension Album {
    var age: Double {
        //         Date() - startDate로 계산
        return 0.0
    }
}
