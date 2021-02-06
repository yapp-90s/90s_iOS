//
//  Film.swift
//  90s
//
//  Created by 김진우 on 2020/12/27.
//

import Foundation

struct Film {
    let id: String
    var name: String
    let createDate: String
    var completeDate: String?
    let filter: String
    private(set) var photos: [Photo]
    let maxCount: Int
    
    @discardableResult
    mutating func add(_ photo: Photo) -> Bool {
        guard !isFull else { return false }
        photos.append(photo)
        return true
    }
}

extension Film {
    var count: Int {
        photos.count
    }
    
    var isFull: Bool {
        photos.count == maxCount
    }
}
