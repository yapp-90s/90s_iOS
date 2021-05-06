//
//  Album.swift
//  90s
//
//  Created by 김진우 on 2020/12/27.
//

import UIKit

struct Album {
    let id: String //var index: Int!
    var user: [String] = []
    let name: String
    var date: String
//    let template: AlbumLayout
    let maxCount: Int
    let cover: AlbumCover
    private(set) var photos: [Photo] = []
}

extension Album {
    var age: Double {
//         Date() - startDate로 계산
        return 0.0
    }
}
