//
//  FilmResponse.swift
//  90s
//
//  Created by 성다연 on 2021/07/19.
//

import Foundation

struct FilmResponse: Codable {
    var filmUid : Int
    var name : String
    var filmCode : Int
    var createdAt : String
    var printStartedAt : String?
    var printEndedAt : String?
    var deletedAt : String?
    
    var film: Film {
        return Film(filmUid: filmUid, name: name, filmCode: filmCode, createdAt: createdAt, printStartAt: printStartedAt, printEndAt: printEndedAt, deletedAt: deletedAt, photos: [])
    }
}


