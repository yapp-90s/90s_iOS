//
//  FilmMainSectionModel.swift
//  90s
//
//  Created by 성다연 on 2021/06/11.
//

import RxDataSources

struct FilmMainSectionModel : SectionModelType {
    var header : String
    var items : [Photo]
    
    typealias Item = Photo
    
    init(original: FilmMainSectionModel, items : [Photo]) {
        self = original
        self.items = items
    }
}

