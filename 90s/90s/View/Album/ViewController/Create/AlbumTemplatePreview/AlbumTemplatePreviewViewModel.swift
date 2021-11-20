//
//  AlbumTemplateViewModel.swift
//  90s
//
//  Created by 김진우 on 2021/11/20.
//

import Foundation

import RxSwift
import RxRelay
import RxDataSources

final class AlbumTemplatePreviewViewModel: ViewModelType {
    
    private(set) var dependency: Dependency
    private(set) var input: Input
    private(set) var output: Output
    
    let disposeBag = DisposeBag()

    init(dependency: Dependency) {
        self.dependency = dependency
        self.input = .init()
        self.output = .init(input: input, dependency: dependency)
    }
    
    // MARK: - Method
    func viewModelForAlbumCreatePreviewViewModel() -> AlbumCompleteViewModel {
        let viewModel = AlbumCompleteViewModel(dependency: .init(albumCreate: output.albumCreate))
        return viewModel
    }
}

extension AlbumTemplatePreviewViewModel {
    typealias TemplateSectionModel = SectionModel<String, TemplateViewModel>
    
    struct Dependency {
        let albumCreate: AlbumCreate
        let templateService: TemplateService = .shared
    }
    
    struct Input {
        let selectTemplate = PublishRelay<IndexPath>()
        let next = PublishRelay<Void>()
    }
    
    struct Output {
        let templateSection: Observable<[TemplateSectionModel]>
        let albumCreate: AlbumCreate
        let next: Observable<Void>
        
        init(input: Input, dependency: Dependency) {
            templateSection = Observable.just(dependency.templateService.all())
                .map { [.init(model: "", items: $0.map { .init(template: $0) })] }
            self.albumCreate = dependency.albumCreate
            self.next = input.next.asObservable()
        }
    }
}
