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
    private(set) var input = Input()
    private(set) var output = Output()
    
    var disposeBag = DisposeBag()
    
    init(dependency: Dependency) {
        self.dependency = dependency
        
        bind()
    }
    
    private func bind() {
        AlbumRepository.shared.albums
            .map { albums in
                return [
                    AlbumSectionModel.sectionCreate(item: .statusCreate(viewModel: self.output.createViewModel)),
                    .sectionBanner,
                    .sectionHeader(items: [.statusHeader(title: "")]),
                    .sectionCover(items: albums.map { AlbumSectionItem.statusCover(albums: $0) }),
                    .sectionHeader(items: [.statusHeader(title: "")]),
                    .sectionPreview(items: albums.map { AlbumSectionItem.statusPreview(albums: $0) })
                ]
            }
            .bind(to: output.albumSection)
            .disposed(by: disposeBag)
    }
}

extension AlbumsViewModel {
    struct Dependency {
    }
    
    struct Input {
    }
    
    struct Output {
        let createViewModel: AlbumCreateCellViewModel = .init()
        let albumSection: BehaviorRelay<[AlbumSectionModel]> = .init(value: [])
    }
}
