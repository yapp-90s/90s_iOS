//
//  AlbumCreatePreviewViewModel.swift
//  90s
//
//  Created by 김진우 on 2021/11/20.
//

import Foundation

import RxSwift
import RxRelay
import RxDataSources

final class AlbumCompleteViewModel: ViewModelType {
    
    private(set) var dependency: Dependency
    private(set) var input: Input
    private(set) var output: Output
    
    let disposeBag = DisposeBag()

    init(dependency: Dependency) {
        self.dependency = dependency
        self.input = .init()
        self.output = .init(input: input, dependency: dependency)
    }
}

extension AlbumCompleteViewModel {
    struct Dependency {
        let albumCreate: AlbumCreate
        let repository = AlbumRepository.shared
    }
    
    struct Input {
        let back = PublishRelay<Void>()
        let close = PublishRelay<Void>()
        let complete = PublishRelay<Void>()
    }
    
    struct Output {
        let albumCreate: AlbumCreate
        let back: Observable<Void>
        let close: Observable<Void>
        let complete: Observable<Void>
        
        init(input: Input, dependency: Dependency) {
            self.albumCreate = dependency.albumCreate
            
            self.back = input.back.asObservable()
            
            self.close = input.close.asObservable()
            
            self.complete = input.complete
                .map { _ in dependency.albumCreate }
                .map(dependency.repository.create.accept)
                .map { _ in () }
                .asObservable()
        }
    }
}
