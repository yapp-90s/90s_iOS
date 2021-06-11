//
//  AlbumResponse.swift
//  90s
//
//  Created by woong on 2021/05/15.
//

import Foundation

struct AlbumResponse: Codable {
    var uid: Int
    var name: String
    var totPaper: Int
    var createdAt: String
    var updatedAt: String
    var completedAt: String?
    var albumCover: AlbumCover
    // layout 추가필요
    
    var album: Album {
        return Album(id: "\(uid)",
                     name: name,
                     createdAt: createdAt,
                     updatedAt: updatedAt,
                     completedAt: completedAt,
                     totalPaper: totPaper,
                     cover: albumCover,
                     photos: [])
    }
}
