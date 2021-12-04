//
//  FilmResponse.swift
//  90s
//
//  Created by 성다연 on 2021/07/19.
//

import Foundation

struct FilmResponse: Codable {
    var uid : Int
    var name : String
    var filmType : FilmType
    var createdAt : String
    var printStartAt : String
    var printEndAt : String
    
    var film: Film {
        return Film(uid: uid, name: name, filmType: .init(uid: 0, code: 0, max: 0),printStartAt: printStartAt, printEndAt: printEndAt, photos: [])
    }
}
