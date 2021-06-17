//
//  FilmSample.swift
//  90s
//
//  Created by 성다연 on 2021/04/21.
//

import Foundation
import RxSwift
import RxCocoa
import RxDataSources

enum FilmListSectionItem {
    case statusTimeToPrint(film: Film)
    case statusAdding(films: [Film])
    case statusPrinting(films: [Film])
    case statusCompleted(films: [Film])
}

enum FilmListSectionModel : SectionModelType {
    typealias Item = Film
    
    case sectionTimeToPrint(item: Film)
    case sectionAdding(items: [Film])
    case sectionPrinting(items: [Film])
    case sectionCompleted(items: [Film])
   
    var items: [Film] {
        switch self {
        case .sectionTimeToPrint(let item):
            return [item]
        case .sectionAdding(let items):
            return items
        case .sectionPrinting(let items):
            return items
        case .sectionCompleted(let items):
            return items
        }
    }
    
    init(original: FilmListSectionModel, items: [Film]) {
        switch original {
        case .sectionTimeToPrint(let item):
            self = .sectionTimeToPrint(item: item)
        case .sectionAdding(let item):
            self = .sectionAdding(items: item)
        case .sectionPrinting(let item):
            self = .sectionPrinting(items: item)
        case .sectionCompleted(let item):
            self = .sectionCompleted(items: item)
        }
    }
    
}

//struct FilmListSectionData {
//    var header : String
//    var items : [FilmListSectionItem]
//}
//
//extension FilmListSectionData : SectionModelType {
//    typealias Item = FilmListSectionItem
//    
//    init(original: FilmListSectionData, items: [FilmListSectionItem]) {
//        self = original
//        self.items = items
//    }
//}
