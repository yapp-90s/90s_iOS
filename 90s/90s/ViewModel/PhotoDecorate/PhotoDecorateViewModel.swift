//
//  StickerViewModel.swift
//  90s
//
//  Created by woong on 2021/02/07.
//

import Foundation
import RxSwift

class PhotoDecorateViewModel: ViewModelType {
    
    let dependency: Dependency
    let input: Input
    let output: Output
    var disposeBag = DisposeBag()
    
    required init(dependency: Dependency) {
        self.dependency = dependency
        
        self.input = Input(
            fetchStickerPacks: PublishSubject<StickerPackCategory>(),
            fetchStickers: PublishSubject<StickerPack>()
        )
        
        self.output = Output(
            photo: BehaviorSubject<Photo>(value: dependency.photo)
        )
    }
    
}

extension PhotoDecorateViewModel {
    
    struct Dependency {
        var photo: Photo
    }
    
    struct Input {
        var fetchStickerPacks: Observable<StickerPackCategory>
        var fetchStickers: Observable<StickerPack>
    }
    
    struct Output {
        var photo: Observable<Photo>
    }
}
