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
    let pages: [Page]
    
    init(uid: Int, cover: Cover, template: Template, name: String, readCount: Int?, isComplete: Bool, completedAt: String?, photos: [Photo]) {
        self.uid = uid
        self.cover = cover
        self.template = template
        self.name = name
        self.readCount = readCount
        self.isComplete = isComplete
        self.completedAt = completedAt
        self.photos = photos
        self.pages = Photo.convertToPages(from: photos, template: template)
    }
}

extension Album {
    var age: Double {
        //         Date() - startDate로 계산
        return 0.0
    }
}
