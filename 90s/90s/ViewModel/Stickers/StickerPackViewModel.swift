//
//  StickerPackViewModel.swift
//  90s
//
//  Created by woong on 2021/03/06.
//

import Foundation
import RxSwift
import RxRelay

class StickerPackViewModel: ViewModelType {
    var dependency: Dependency
    var input = Input()
    var output = Output()
    var disposeBag = DisposeBag()
    
    required init(dependency: Dependency) {
        self.dependency = dependency
        output.packName.accept(dependency.stickerPack.name)
        output.stickers.accept(dependency.stickerPack.stickers)
        
        input.fetchStickers
            .map { $0.stickers }
            .bind(to: output.stickers)
            .disposed(by: disposeBag)
        
        input.fetchStickers
            .map { $0.name }
            .bind(to: output.packName)
            .disposed(by: disposeBag)
        
        input.addSticker
            .map { [unowned self] in self.output.stickers.value[$0] }
            .subscribe(onNext: { sticker in
                dependency.photoDecorateViewModel?.input.addSticker.onNext(sticker)
            })
            .disposed(by: disposeBag)
    }
}

extension StickerPackViewModel {
    struct Dependency {
        weak var photoDecorateViewModel: PhotoDecorateViewModel?
        var stickerPack: StickerPack
    }
    
    struct Input {
        var fetchStickers = PublishSubject<StickerPack>()
        var addSticker = PublishSubject<Int>()
    }
    
    struct Output {
        var stickers = BehaviorRelay<[Sticker]>(value: [])
        var packName = BehaviorRelay<String>(value: "스티커팩이름")
    }
}
