//
//  AlbumListViewModel.swift
//  90s
//
//  Created by 김진우 on 2021/11/20.
//

import Foundation

import RxSwift
import RxRelay
import RxDataSources

final class AlbumListViewModel: ViewModelType {
    
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

extension AlbumListViewModel {
    typealias AlbumsSectionModel = SectionModel<String, AlbumViewModel>
    
    struct Dependency {
        let albumRepository: AlbumRepository
    }
    
    struct Input {
        let selectAlbum = PublishRelay<IndexPath>()
        let back = PublishRelay<Void>()
        let edit = PublishRelay<Void>()
    }
    
    struct Output {
        let albumSection: Observable<[AlbumsSectionModel]>
        let back: Observable<Void>
        let edit: Observable<Void>
        
        init(input: Input, dependency: Dependency) {
            albumSection = dependency.albumRepository.albums
                .map { [.init(model: "", items: $0)] }
            
            back = input.back
                .asObservable()
            
            edit = input.edit
                .asObservable()
        }
    }
}
