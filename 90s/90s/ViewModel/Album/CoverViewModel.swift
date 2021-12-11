//
//  CoverViewModel.swift
//  90s
//
//  Created by 김진우 on 2021/04/22.
//

import RxSwift
import RxRelay

class CoverViewModel {
    let cover: BehaviorRelay<Cover>
    
    init(albumCover: Cover) {
        cover = BehaviorRelay<Cover>.init(value: albumCover)
    }
}
