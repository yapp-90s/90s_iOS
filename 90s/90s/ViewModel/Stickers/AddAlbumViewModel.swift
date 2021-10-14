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
        
        self.input.downloadImage
            .subscribe(onNext: { [weak self] _ in
                self?.output.isLoading.onNext(true)
                self?.dependency.imageService.saveImage(dependency.decoratedImage)
            })
            .disposed(by: self.disposeBag)
        
        self.input.tappedShareButton
            .bind(to: self.output.showShareActionSheet)
            .disposed(by: self.disposeBag)
        
        self.input.tappedCloseButton
            .subscribe(onNext: { [weak self] _ in
                self?.output.showCloseEdit.onNext(())
            })
            .disposed(by: self.disposeBag)
        
        dependency.imageService.saveCompletion
            .subscribe(onNext: { [weak self] response in
                self?.responseImageService(response)
            })
            .disposed(by: self.disposeBag)
    }
    
    func responseImageService(_ response: ImageServiceResponse) {
        switch response {
            case .success:
                output.isLoading.onNext(false)
            default: return
        }
    }
}

extension AddAlbumViewModel {
    
    struct Dependency {
        var decoratedImage: Data
        var imageService: ImageServiceProtocol
    }
    
    struct Input {
        var downloadImage = PublishSubject<Void>()
        var tappedShareButton = PublishSubject<Void>()
        var tappedCloseButton = PublishSubject<Void>()
    }
    
    struct Output {
        var decoratedImage: BehaviorRelay<Data>
        var isLoading = BehaviorSubject<Bool>(value: false)
        var showCloseEdit = PublishSubject<Void>()
        var showShareActionSheet = PublishSubject<Void>()
    }
}
