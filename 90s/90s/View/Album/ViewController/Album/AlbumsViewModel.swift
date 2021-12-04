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
        let createAlbumButton = PublishRelay<Void>()
        let selectMakingAlbum = PublishRelay<IndexPath>()
        let selectAlbum = PublishRelay<IndexPath>()
    }
    
    struct Output {
        let createViewModel: Observable<AlbumCoverViewModel>
        let selectedMakingAlbum: Observable<AlbumViewModel>
        let selectedAlbum: Observable<AlbumViewModel>
        
        let albumSection: Observable<[AlbumSectionModel]>
        
        init(input: Input, dependency: Dependency) {
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
            
            albumSection = dependency.albumRepository.albums
                .map { albums in
                    return [
                        AlbumSectionModel.sectionCreate(item: .statusCreate(viewModel: .init())),
                        .sectionBanner,
                        .sectionHeader(items: [.statusHeader(title: "")]),
                        .sectionCover(items: albums.map { AlbumSectionItem.statusCover(albums: $0) }),
                        .sectionHeader(items: [.statusHeader(title: "")]),
                        .sectionPreview(items: albums.map { AlbumSectionItem.statusPreview(albums: $0) })
                    ]
                }
                .asObservable()
        }
    }
}
