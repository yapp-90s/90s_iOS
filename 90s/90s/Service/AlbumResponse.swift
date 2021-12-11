//
//  AlbumResponse.swift
//  90s
//
//  Created by woong on 2021/05/15.
//

import Foundation

struct AlbumResponse: Codable {
    let albumUid: Int
    let coverCode: Int
    let layoutCode: Int
    let name: String
    let readCnt: Int
    let isComplete: Bool
    let completedAt: String?
    let photos: [Photo]
//    let createdAt: String
//    let updatedAt: String
    
//    var totPaper: Int
//    var createdAt: String
//    var updatedAt: String
//    var completedAt: String?
//    var albumCover: AlbumCover
    // layout 추가필요
    
    var album: Album? {
        if let cover = CoverService.shared.getCover(coverCode),
           let template = TemplateService.shared.getTemplate(layoutCode) {
            return .init(uid: albumUid,
                         cover: cover,
                         template: template,
                         name: name,
                         readCount: readCnt,
                         isComplete: isComplete,
                         completedAt: completedAt,
                         photos: photos)
        }
        return nil
    }
}
