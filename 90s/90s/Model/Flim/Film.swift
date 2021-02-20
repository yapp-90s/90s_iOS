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

// MARK: 임시로 만든 필름 데이터


struct TestFilm {
    var filmName : String
    var filmImage : String
    var filmType : FilmType?
}

extension TestFilm : Equatable {
    static func ==(lrs : TestFilm, rls : TestFilm) -> Bool {
        return lrs.filmName == rls.filmName
    }
}

enum FilmType {
    case Cold
    case Cute
    case Nice
    case Hot
    case Dandy
}
extension FilmType {
    var count: Int {
        self.hashValue
    }
}
