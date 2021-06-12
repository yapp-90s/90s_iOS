//
//  AddAlbumViewModel.swift
//  90s
//
//  Created by woong on 2021/06/11.
//

import Foundation
import RxSwift
import RxRelay

class AddAlbumViewModel: ViewModelType {
    private(set) var dependency: Dependency
    private(set) var input = Input()
    private(set) var output: Output
    private(set) var disposeBag = DisposeBag()
    
    required init(dependency: Dependency) {
        self.dependency = dependency
        self.output = Output(decoratedImage: BehaviorRelay<Data>.init(value: dependency.decoratedImage))
        
        input.downloadImage
            .subscribe(onNext: { [weak self] _ in
                self?.saveImage(dependency.decoratedImage)
            })
            .disposed(by: disposeBag)
    }
    
    func saveImage(_ data: Data) {
        guard let image = UIImage(data: data) else { return }
        UIImageWriteToSavedPhotosAlbum(image, nil, nil, nil)
    }
}

extension AddAlbumViewModel {
    
    struct Dependency {
        var decoratedImage: Data
    }
    
    struct Input {
        var downloadImage = PublishSubject<Void>()
    }
    
    struct Output {
        var decoratedImage: BehaviorRelay<Data>
    }
}
