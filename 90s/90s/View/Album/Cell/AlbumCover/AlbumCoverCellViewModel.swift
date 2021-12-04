//
//  AlbumCoverCellViewModel.swift
//  90s
//
//  Created by 김진우 on 2021/11/20.
//

import Foundation

import RxSwift
import RxRelay
import RxDataSources

final class AlbumCoverCellViewModel: ViewModelType {
    
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

extension AlbumCoverCellViewModel {
    typealias TemplateSectionModel = SectionModel<String, TemplateViewModel>
    
    struct Dependency {
        let albumViewModel: AlbumViewModel
    }
    
    struct Input {
        let edit = PublishRelay<Bool>()
    }
    
    struct Output {
        let isEdit: Observable<Bool>
        let albumViewModel: AlbumViewModel
        
        init(input: Input, dependency: Dependency) {
            self.albumViewModel = dependency.albumViewModel
            self.isEdit = input.edit
                .asObservable()
        }
    }
}
