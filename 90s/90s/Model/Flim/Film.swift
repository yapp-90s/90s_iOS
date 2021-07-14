//
//  Film.swift
//  90s
//
//  Created by 김진우 on 2020/12/27.
//

import Foundation


struct Film {
    let uid: Int
    var name: String
    var filmType : FilmType
    var user : User
    
    let createdAt: String = Date().dateToString()
    var printStartAt : String?
    var printEndAt: String?
    
    // - None Network Data
    private(set) var photos: [Photo]
    
    let maxCount: Int
    var state : FilmStateType = .adding
    
    @discardableResult
    mutating func add(_ photo: Photo) -> Bool {
        guard !isFull else { return false }
        photos.append(photo)
        return true
    }
    
    @discardableResult
    mutating func addAtFirst(_ photo : Photo) -> Bool {
        guard !isFull else { return false }
        photos.insert(photo, at: 0)
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

/// Film 제작의 상태표
enum FilmStateType : Int, Hashable {
    case create = 0
    case adding = 1
    case printing = 2
    case complete = 3
    
    func image() -> String {
        switch self {
        case .create: return ""
        case .adding: return "film_state_adding"
        case .printing: return "film_state_print"
        case .complete: return "film_state_complete"
        }
    }
    
    func text() -> String {
        switch self {
        case .create, .adding:
            return "사진 추가 중"
        case .printing, .complete:
            return "인화완료"
        }
    }
}

/// Film 필터 종류
enum FilmFilterType : String {
    case Create = ""
    case Cold = "차가운 필름"
    case Cute = "귀여운 필름"
    case Nice = "멋진 필름"
    case Hot = "강렬한 필름"
    case Dandy = "진지한 필름"

    var id: Int {
        self.hashValue
    }
    
    func printDay() -> Int {
        switch self {
        case .Cold, .Cute, .Nice, .Hot:
            return 6
        case .Dandy:
            return 12
        default:
            return 0
        }
    }
    
    func image() -> String {
        switch self {
        case .Create:
            return "film_create"
        case .Cold, .Cute, .Nice, .Hot, .Dandy :
            return "film_default"
        }
    }
}

