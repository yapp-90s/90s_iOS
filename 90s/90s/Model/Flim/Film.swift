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
    var filmType : FilmFilterType
    var user : User?
    
    var createdAt = Date().toString
    var printStartAt : String?
    var printEndAt: String?
    
    // - None Network Data
    private(set) var photos: [Photo]
    
    let maxCount: Int
    
    var filmState : FilmStateType {
        get {
            if maxCount == -1 {
                return .create
            } else if photos.count >= maxCount {
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
        photos.count == maxCount
    }
}

/// Film 제작의 상태표
enum FilmStateType : Int, Codable {
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
        case .create: return ""
        case .adding: return "사진 추가 중"
        case .printing: return "인화중"
        case .complete: return "인화완료"
        }
    }
}

/// Film 필터 종류
enum FilmFilterType : String, Codable {
    case Create = "Create"
    case None = "None"
    case Mono = "Mono"
    case MossPink = "MossPink"
    case ForgetMeNot = "ForgetMeNot"
    
    var id : Int {
        switch self {
        case .Create : return 0
        case .None : return 1001
        case .Mono : return 1002
        case .MossPink : return 1003
        case .ForgetMeNot : return 1004
        }
    }
    
    var printDaysCount : Int {
        return 12
    }
    
    var photoCount : Int {
        return 36
    }
    
    var image : String {
        switch self {
        case .Create : return "film_default"
        case .None : return "filmroll_none"
        case .Mono : return "filmroll_mono"
        case .MossPink : return "filmroll_mosspink"
        case .ForgetMeNot : return "filmroll_forgetmenot"
        }
    }
    
    var color : Int {
        switch self {
        case .None : return 0x727379
        case .Mono : return 0x53555A
        case .MossPink : return 0x8276AF
        case .ForgetMeNot : return 0x517796
        default : return 0xFFFFFF
        }
    }
    
    var imageWidth : Int {
        switch self {
        case .None : return 60
        case .Mono : return 80
        case .MossPink : return 60
        case .ForgetMeNot : return 80
        default: return 0
        }
    }
    
    var maxCountImageView : Int {
        switch self {
        case .None, .MossPink : return 4
        case .Mono, .ForgetMeNot: return 3
        default: return 0
        }
    }
}

