//
//  StickerPackViewModel.swift
//  90s
//
//  Created by woong on 2021/03/05.
//

import RxSwift
import RxRelay

class StickerPackViewModel: ViewModelType {
    private(set) var dependency: Dependency
    private(set) var input = Input()
    private(set) var output = Output()
    private(set) var disposeBag = DisposeBag()

    required init(dependency: Dependency) {
        self.dependency = dependency
        
        input.selectedCategory
            .bind(to: output.currentCategory)
            .disposed(by: disposeBag)
        
        input.selectedCategory
            .map { dependency.stickerFactory.stickerPackList(of: $0) }
            .bind(to: output.stickerPackList)
            .disposed(by: disposeBag)
    }
}

extension StickerPackViewModel {
    struct Dependency {
        var stickerFactory = StickerFactory()
    }

    struct Input {
        var selectedCategory = BehaviorSubject<StickerPackCategory>(value: .basic)
        var selectedStickerPack = PublishSubject<Int>()
    }

    struct Output {
        var currentCategory = BehaviorRelay<StickerPackCategory>(value: .basic)
        var stickerPackList = BehaviorRelay<[StickerPack]>(value: [])
    }
}
