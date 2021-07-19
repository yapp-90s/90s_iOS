//
//  PhotoResponse.swift
//  90s
//
//  Created by 성다연 on 2021/07/19.
//

import Foundation

struct PhotoResponse : Codable {
    var uid : Int
    var url : String
    var film : Film
    var createdAt : String
    var updatedAt : String
}
