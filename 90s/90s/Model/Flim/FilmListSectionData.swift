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
    
    var name : String {
        switch self {
        case .sectionTimeToPrint:
            return "인화할 시간!"
        case .sectionAdding:
            return "사진을 추가하고 있어요"
        case .sectionPrinting:
            return "지금 인화하고 있어요"
        case .sectionCompleted:
            return "인화를 완료했어요"
        }
    }
    
    var heightForSection : CGFloat {
        switch self {
        case .sectionTimeToPrint:
            return 70
        default:
            return 50
        }
    }
    
    var heightForRow : CGFloat {
        switch self {
        case .sectionTimeToPrint:
            return 360
        default:
            return 210
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
