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
