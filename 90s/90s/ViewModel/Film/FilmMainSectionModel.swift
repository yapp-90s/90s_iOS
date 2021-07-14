//
//  FilmMainSectionModel.swift
//  90s
//
//  Created by 성다연 on 2021/06/11.
//

import RxDataSources

struct FilmMainSectionModel  {
    var header : String
    var items : [Photo]
}

extension FilmMainSectionModel : SectionModelType {
    typealias Item = Photo
    
    init(original: FilmMainSectionModel, items : [Photo]) {
        self = original
        self.items = items
    }
}

