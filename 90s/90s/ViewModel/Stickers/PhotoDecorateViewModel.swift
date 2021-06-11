//
//  StickerDecorationViewModel.swift
//  90s
//
//  Created by woong on 2021/03/06.
//

import Foundation
import RxSwift
import RxRelay

class PhotoDecorateViewModel: ViewModelType {
    var dependency: Dependency
    var input = Input()
    var output: Output
    var disposeBag = DisposeBag()
    
    required init(dependency: Dependency) {
        self.dependency = dependency
        self.output = Output(
            photo: .init(value: dependency.selectedPhoto),
            isResizableStickers: .init(value: true)
        )
        
        input.viewWillAppear
            .subscribe(onNext: { [weak self] _ in
                self?.output.isResizableStickers.accept(true)
            })
            .disposed(by: disposeBag)
        
        input.changeResizableOfAllStickers
            .bind(to: output.isResizableStickers)
            .disposed(by: disposeBag)
    }
}

extension PhotoDecorateViewModel {
    struct Dependency {
        var selectedPhoto: Photo
    }
    
    struct Input {
        var viewWillAppear = PublishSubject<Void>()
        var addSticker = PublishSubject<Sticker>()
        var changeResizableOfAllStickers = PublishSubject<Bool>()
    }
    
    struct Output {
        var photo: BehaviorRelay<Photo>
        var isResizableStickers: BehaviorRelay<Bool>
    }
}
