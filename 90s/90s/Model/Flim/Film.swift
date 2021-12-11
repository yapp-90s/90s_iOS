//
//  Film.swift
//  90s
//
//  Created by 김진우 on 2020/12/27.
//

import Foundation

struct Film : Codable {
    let uid: Int
    var name: String
    var filmType : FilmType
    var user : User?
    
    var createdAt = Date().toString
    var printStartAt : String?
    var printEndAt: String?
    
    // - None Network Data
    private(set) var photos: [Photo]
   
    var filmState : FilmStateType {
        get {
            if filmType.max == -1 {
                return .create
            } else if photos.count >= filmType.max {
                return printStartAt != nil ? .complete : .printing
            } else {
                return .adding
            }
        }
    }
    
    @discardableResult
    mutating func addAtFirst(_ photo: Photo) -> Bool {
        guard !isFull else { return false }
        photos.insert(photo, at: 0)
        return true
    }
    
    static func ==(rhs: Film, lhs: Film) -> Bool {
        return rhs.uid == lhs.uid && rhs.name == lhs.name
    }
}

extension Film {
    var count: Int {
        photos.count
    }
    
    var isFull: Bool {
        photos.count == filmType.max
    }
}

/// Film 제작의 상태표
enum FilmStateType : Int, Codable {
    case create = 0
    case adding = 1
    case printing = 2
    case complete = 3
    case timeprint = 4
    
    func image() -> String {
        switch self {
        case .create, .timeprint: return ""
        case .adding:   return "film_state_adding"
        case .printing: return "film_state_print"
        case .complete: return "film_state_complete"
        }
    }
    
    func tagText() -> String {
        switch self {
        case .create, .timeprint: return ""
        case .adding:   return "사진 추가 중"
        case .printing: return "인화중"
        case .complete: return "인화완료"
        }
    }
    
    func sectionText() -> String {
        switch self {
        case .create:   return ""
        case .timeprint:return "인화할 시간!"
        case .adding:   return "사진을 추가하고 있어요"
        case .printing: return "지금 인화하고 있어요"
        case .complete: return "인화를 완료했어요"
        }
    }
    
    func sectionHeight() -> Int {
        switch self {
        case .timeprint: return 70
        default:         return 50
        }
    }
    
    func rowHeight() -> Int {
        switch self {
        case .timeprint: return 360
        default:         return 210
        }
    }
}
