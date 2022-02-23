//
//  AlbumDetailCollectionViewModel.swift
//  90s
//
//  Created by 김진우 on 2022/01/22.
//

import Foundation

import RxSwift
import RxRelay
import RxDataSources

typealias AlbumDetailCollectionSectionModel = SectionModel<Void, TemplateImageCellViewModel>
typealias AlbumDetailCollectionDataSource = RxCollectionViewSectionedReloadDataSource<AlbumDetailCollectionSectionModel>

final class AlbumDetailCollectionViewModel: ViewModelType {
    
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

extension AlbumDetailCollectionViewModel {
    
    struct Dependency {
        let albumViewModel: AlbumViewModel
    }
    
    struct Input {
        let back = PublishRelay<Void>()
        let close = PublishRelay<Void>()
//        let load = PublishRelay<Void>()
    }
    
    struct Output {
        let back: Observable<Void>
        let close: Observable<Void>
        let title: Observable<String?>
        let templatePhotoSection: BehaviorRelay<[AlbumDetailCollectionSectionModel]>
        
        init(input: Input, dependency: Dependency) {
            back = input.back
                .asObservable()
            
            close = input.close
                .asObservable()
            
            title = dependency.albumViewModel.name
            
            templatePhotoSection = .init(value: [.init(model: (), items: dependency.albumViewModel.album.photos.map { .init(dependency: .init(template: dependency.albumViewModel.album.template, photo: $0)) })])
            bindAction(input: input)
        }
        
        private func bindAction(input: Input) {
        }
    }
}
