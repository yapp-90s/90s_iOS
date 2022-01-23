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

typealias AlbumDetailCollectionSectionModel = SectionModel<Void, Template>
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
        
        let templatePhotoSection: BehaviorRelay<[AlbumDetailCollectionDataSource]> = .init(value: [])
    }
    
    struct Output {
        let back: Observable<Void>
        let close: Observable<Void>
        
        init(input: Input, dependency: Dependency) {
            back = input.back
                .asObservable()
            
            close = input.close
                .asObservable()
            
            bindAction(input: input)
        }
        
        private func bindAction(input: Input) {
        }
    }
}
