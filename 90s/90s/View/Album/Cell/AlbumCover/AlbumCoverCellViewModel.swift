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
        let isEdit: Bool
        let isSelected: Bool
    }
    
    struct Input {
//        let select = PublishRelay<Void>()
    }
    
    struct Output {
        private let disposeBag = DisposeBag()
        let albumViewModel: AlbumViewModel
        let isEdit: Observable<Bool>
        let isSelected: BehaviorRelay<Bool>
        
        init(input: Input, dependency: Dependency) {
            self.albumViewModel = dependency.albumViewModel
            
            self.isEdit = Observable.just(dependency.isEdit)
            isSelected = .init(value: dependency.isSelected)
//            let selected = isSelected.value
//            input.select
//                .map { _ in !selected }
//                .bind(to: isSelected)
//                .disposed(by: disposeBag)
        }
    }
}
