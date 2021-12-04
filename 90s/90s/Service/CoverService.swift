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
    
    private let covers = BehaviorRelay<[AlbumCover]>(value: [])
    
    private init() {
        covers.accept([.sweetLittleMemories, .youMakeMeCloudy, .stickyBubble, .candy, .yic])
    }
    
    func all() -> [AlbumCover] {
        return covers.value
    }
    
    func pickCover(_ index: Int) -> AlbumCover {
        return covers.value[index]
    }
    
    func viewModels() -> Observable<[CoverViewModel]> {
        let covers = self.covers.value
        let coverViewModels = covers.map { CoverViewModel(albumCover: $0) }
        return Observable.just(coverViewModels)
    }
}
