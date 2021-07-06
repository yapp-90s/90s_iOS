//
//  DecorateContainerViewModel.swift
//  90s
//
//  Created by woong on 2021/06/11.
//

import Foundation
import RxSwift

class DecorateContainerViewModel: ViewModelType {
    
    private(set) var dependency: Dependency
    private(set) var input = Input()
    private(set) var output: Output
    private(set) var disposeBag = DisposeBag()
    
    private let photoDecorateViewModel: PhotoDecorateViewModel
    private let stickerPackListViewModel: StickerPackListViewModel
    
    required init(dependency: Dependency) {
        self.dependency = dependency
        self.photoDecorateViewModel = PhotoDecorateViewModel(dependency: .init(selectedPhoto: dependency.selectedPhoto))
        self.stickerPackListViewModel = StickerPackListViewModel(dependency: .init(
                                                                    photoDecorateViewModel: photoDecorateViewModel,
                                                                    stickerFactory: StickerFactory()
                                                                ))
        self.output = Output(photoDecorateViewModel: photoDecorateViewModel, stickerPackListViewModel: stickerPackListViewModel)
        
        self.input.completeDecoration
            .subscribe(onNext: { [weak self] _ in
                self?.photoDecorateViewModel.input.changeResizableOfAllStickers.onNext(false)
                self?.photoDecorateViewModel.output.renderDecoratedImage.onNext(())
            })
            .disposed(by: disposeBag)
        
        photoDecorateViewModel.input.decoratedImage
            .subscribe(onNext: { [weak self] imageData in
                self?.output.pushToAddAlbumVC.onNext(
                    AddAlbumViewModel(dependency: .init(decoratedImage: imageData, imageService: ImageService()))
                )
            })
            .disposed(by: disposeBag)
    }
}

extension DecorateContainerViewModel {
    
    struct Dependency {
        var selectedPhoto: Photo
    }
    
    struct Input {
        var completeDecoration = PublishSubject<Void>()
    }
    
    struct Output {
        var photoDecorateViewModel: PhotoDecorateViewModel
        var stickerPackListViewModel: StickerPackListViewModel
        var pushToAddAlbumVC = PublishSubject<AddAlbumViewModel>()
    }
}
