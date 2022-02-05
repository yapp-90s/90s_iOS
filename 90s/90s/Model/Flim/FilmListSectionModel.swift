//
//  FilmSample.swift
//  90s
//
//  Created by 성다연 on 2021/04/21.
//

import Foundation
import RxSwift
import RxDataSources

enum FilmSectionItem {
    case statusTimeToPrint(film: Film)
    case statusAdding(film: Film)
    case statusPrinting(film: Film)
    case statusCompleted(film: Film)
    
    func sectionHeight() -> CGFloat {
        switch self {
        case .statusTimeToPrint: return 70
        default: return 50
        }
    }
    
    func rowHeight() -> CGFloat {
        switch self {
        case .statusTimeToPrint: return 360
        default: return 210
        }
    }
    
    func sectionTitle() -> String {
        switch self {
        case .statusTimeToPrint:
            return "인화할 시간!"
        case .statusAdding:
            return "사진을 추가하고 있어요"
        case .statusPrinting:
            return "지금 인화하고 있어요"
        case .statusCompleted:
            return "인화를 완료했어요"
        }
    }
    
    func returnFilm() -> Film {
        switch self {
        case .statusTimeToPrint(let film),
             .statusAdding(let film),
             .statusPrinting(let film),
             .statusCompleted(let film):
            return film
        }
    }
}

struct FilmSectionModel : SectionModelType {
    typealias Item = FilmSectionItem
    
    var items: [Item]
    
    init(items: [Item]) {
        self.items = items
    }
    
    init(original: FilmSectionModel, items: [Item] = []) {
        self = original
        self.items = items
    }
}
