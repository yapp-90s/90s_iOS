//
//  FilmType.swift
//  90s
//
//  Created by 성다연 on 2021/07/14.
//

import Foundation

struct FilmType : Codable {
    let uid : Int
    let code : Int
    var name : FilmFilterType
    var description : String = ""
    
    let createdAt : String = ""
    var updatedAt : String = ""
    var releasedAt : String = ""
}

