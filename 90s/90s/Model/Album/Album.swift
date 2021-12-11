//
//  Album.swift
//  90s
//
//  Created by 김진우 on 2020/12/27.
//

import UIKit

struct Album {
    let uid: Int
    let cover: Cover
    let template: Template
    let name: String
    let readCount: Int?
    let isComplete: Bool
    let completedAt: String?
    let photos: [Photo]
//    let createdAt: String
//    var updatedAt: String
    //    var user: [String]? = []
//    let endAt: String
//    let template: Template
//    private(set) var photos: [Photo] = []
}

extension Album {
    var age: Double {
        //         Date() - startDate로 계산
        return 0.0
    }
}
