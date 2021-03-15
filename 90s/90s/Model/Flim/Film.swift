//
//  Film.swift
//  90s
//
//  Created by 김진우 on 2020/12/27.
//

import Foundation
import RxSwift
import RxCocoa
import RxDataSources

struct Film {
    let id: String
    var name: String
    let createDate: String = Date().dateToString()
    var completeDate: String?
    var filterType : FilmFilterType
//    let filter: String
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
enum FilmStateType : Int {
    case create = 0
    case adding = 1
    case printing = 2
    case complete = 3
    
    func image() -> String {
        switch self {
        case .create: return ""
        case .adding: return "filmstateaddimg"
        case .printing: return "filmstateprintimg"
        case .complete: return "filmstatecompleteimg"
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
enum FilmFilterType {
    case Create
    case Cold
    case Cute
    case Nice
    case Hot
    case Dandy
}
extension FilmFilterType {
    var count: Int {
        self.hashValue
    }
    
    func image() -> String {
        switch self {
        case .Create:
            return "newfilmimg"
        case .Cold, .Cute, .Nice, .Hot, .Dandy :
            return "filmimg"
        }
    }
}


struct FilmListSectionData {
    var header : String
    var items: [Item]
}

extension FilmListSectionData : SectionModelType {
    typealias Item = Film
    
    init(original: FilmListSectionData, items: [Film]) {
        self = original
        self.items = items
    }
}
