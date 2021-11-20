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
    }
    
    struct Input {
        let next = PublishRelay<Void>()
    }
    
    struct Output {
        let albumCreate: AlbumCreate
        let next: Observable<Void>
        
        init(input: Input, dependency: Dependency) {
            self.albumCreate = dependency.albumCreate
            self.next = input.next.asObservable()
        }
    }
}
