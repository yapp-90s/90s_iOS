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
    }
}

extension DecorateContainerViewModel {
    
    struct Dependency {
        var selectedPhoto: Photo
    }
    
    struct Input {
        
    }
    
    struct Output {
        var photoDecorateViewModel: PhotoDecorateViewModel
        var stickerPackListViewModel: StickerPackListViewModel
    }
}
