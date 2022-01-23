//
//  AlbumDetailViewModel.swift
//  90s
//
//  Created by 김진우 on 2021/12/11.
//

import Foundation

import RxSwift
import RxRelay
import RxDataSources

typealias TemplateSectionModel = SectionModel<Void, TemplateCellViewModel>
typealias TemplateDataSource = RxCollectionViewSectionedReloadDataSource<TemplateSectionModel>

final class AlbumDetailViewModel: ViewModelType {
    
    private(set) var dependency: Dependency
    private(set) var input: Input
    private(set) var output: Output
    
    var disposeBag = DisposeBag()
    
    init(dependency: Dependency) {
        self.dependency = dependency
        self.input = .init()
        self.output = .init(input: input, dependency: dependency)
    }
}

extension AlbumDetailViewModel {
    
    struct Dependency {
        let isEditing: Bool
        let albumViewModel: AlbumViewModel
    }
    
    struct Input {
        let controlBarToggle = PublishRelay<Void>()
        let back = PublishRelay<Void>()
        let close = PublishRelay<Void>()
    }
    
    struct Output {
        private let disposeBag = DisposeBag()
        
        let title: Observable<String?>
        let pageSection: BehaviorRelay<[TemplateSectionModel]> = .init(value: [])
        let back: Observable<Void>
        let close: Observable<Void>
        let controlBarIsHidden: BehaviorRelay<Bool> = .init(value: true)
        
        init(input: Input, dependency: Dependency) {
            dependency.albumViewModel.pages
                .filter { $0 != nil }
                .map { $0! }
                .map { [.init(model: (), items: $0.map { .init(dependency: .init(isEditing: dependency.isEditing, page: $0, template: dependency.albumViewModel.album.template))})]}
                .bind(to: pageSection)
                .disposed(by: disposeBag)
            
            title = dependency.albumViewModel.name
            
            back = input.back
                .asObservable()
            
            close = input.close
                .asObservable()
            
            bindAction(input: input)
        }
        
        private func bindAction(input: Input) {
            input.controlBarToggle
                .map { _ in
                    !self.controlBarIsHidden.value
                }
                .bind(to: controlBarIsHidden)
                .disposed(by: disposeBag)
        }
    }
}
