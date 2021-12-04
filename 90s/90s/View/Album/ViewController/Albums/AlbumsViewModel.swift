//
//  AlbumsViewModel.swift
//  90s
//
//  Created by 김진우 on 2021/04/08.
//

import Foundation

import RxSwift
import RxRelay

final class AlbumsViewModel: ViewModelType {
    
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

extension AlbumsViewModel {
    struct Dependency {
        let albumRepository: AlbumRepository
    }
    
    struct Input {
        let refresh = PublishRelay<Void>()
        let createAlbumButton = PublishRelay<Void>()
        let selectMakingAlbum = PublishRelay<IndexPath>()
        let selectAlbum = PublishRelay<IndexPath>()
    }
    
    struct Output {
        let albumSection: Observable<[AlbumSectionModel]>
        let createViewModel: Observable<AlbumCoverViewModel>
        let selectedMakingAlbum: Observable<AlbumViewModel>
        let selectedAlbum: Observable<AlbumViewModel>
        
        private let albumRelay: PublishRelay<[AlbumSectionModel]> = .init()
        
        private let disposeBag = DisposeBag()
        
        init(input: Input, dependency: Dependency) {
            input.refresh
                .bind(to: dependency.albumRepository.requestAll)
                .disposed(by: disposeBag)
            
            Observable.zip(dependency.albumRepository.makeingAlbums, dependency.albumRepository.completeAlbums)
                .do(onNext: { (a, b) in
                    print(a)
                    print(b)
                })
                .map { (makingAlbums, completeAlbums) in
                    return [
                        AlbumSectionModel.sectionCreate(item: .statusCreate(viewModel: .init())),
                        .sectionBanner,
                        .sectionHeader(items: [.statusHeader(title: "")]),
                        .sectionCover(items: makingAlbums.map { AlbumSectionItem.statusCover(albums: .init(album: $0)) }),
                        .sectionHeader(items: [.statusHeader(title: "")]),
                        .sectionPreview(items: completeAlbums.map { AlbumSectionItem.statusPreview(albums: .init(album: $0)) })
                    ]
                }
                .bind(to: albumRelay)
                .disposed(by: disposeBag)
            
            albumSection = albumRelay.asObservable()
            
            createViewModel = input.createAlbumButton
                .map { _ in .init(dependency: .init(coverService: CoverService.shared, albumRepository: .shared)) }
                .asObservable()
            
            selectedMakingAlbum = input.selectMakingAlbum
                .map { $0.item }
                .map(dependency.albumRepository.pickMakingAlbum)
                .asObservable()
            
            selectedAlbum = input.selectAlbum
                .map { $0.item }
                .map(dependency.albumRepository.pickAlbum)
                .asObservable()
        }
    }
}
