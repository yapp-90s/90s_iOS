//
//  StickerPackViewModel.swift
//  90s
//
//  Created by woong on 2021/03/05.
//

import RxSwift
import RxRelay

class StickerPackViewModel: ViewModelType {
    var dependency: Dependency
    var input = Input()
    var output = Output()
    var disposeBag = DisposeBag()

    required init(dependency: Dependency) {
        self.dependency = dependency
        
        input.selectedCategory
            .bind(to: output.currentCategory)
            .disposed(by: disposeBag)
    }
}

extension StickerPackViewModel {
    struct Dependency {
        
    }

    struct Input {
        var selectedCategory = PublishSubject<StickerPackCategory>()
        var selectedStickerPack = PublishSubject<Int>()
    }

    struct Output {
        var currentCategory = BehaviorRelay<StickerPackCategory>(value: .basic)
        var stickerPackList = BehaviorRelay<[StickerPack]>(value: [
            StickerPack(name: "설날", thumbnailImageName: "filmimg", stickers: [], category: .basic),
            StickerPack(name: "이름이름이름이름이름이름이름이름이름이름이름이름", thumbnailImageName: "filmimg", stickers: [], category: .basic),
            StickerPack(name: "이름이름", thumbnailImageName: "filmimg", stickers: [], category: .basic),
            StickerPack(name: "아름아름", thumbnailImageName: "filmimg", stickers: [], category: .basic)
        ])
    }
}
