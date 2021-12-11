//
//  CoverService.swift
//  90s
//
//  Created by 김진우 on 2021/04/18.
//

import RxSwift
import RxCocoa
import RxRelay

final class CoverService {
    
    static let shared = CoverService()
    
    private let covers = BehaviorRelay<[Cover]>(value: [])
    
    private init() {
        covers.accept([
                        .init(code: 1001, name: "Sweet Little Memories", fileName: "AlbumSweetLittleMemories"),
                        .init(code: 1002, name: "You Make Me Cloudy", fileName: "AlbumYouMakeMeCloudy"),
                        .init(code: 1003, name: "Sticky Bubble", fileName: "AlbumStickyBubble"),
                        .init(code: 1004, name: "Candy", fileName: "AlbumCandy"),
                        .init(code: 1005, name: "YIC", fileName: "AlbumYIC")
        ])
    }
    
    func all() -> [Cover] {
        return covers.value
    }
    
    func pickCover(_ index: Int) -> Cover {
        return covers.value[index]
    }
    
    func getCover(_ code: Int) -> Cover? {
        return covers.value.filter({ $0.code == code }).first
    }
    
    func viewModels() -> Observable<[CoverViewModel]> {
        let covers = self.covers.value
        let coverViewModels = covers.map { CoverViewModel(albumCover: $0) }
        return Observable.just(coverViewModels)
    }
}
