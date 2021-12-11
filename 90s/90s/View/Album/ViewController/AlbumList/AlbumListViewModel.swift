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
    typealias AlbumsCoverSectionModel = SectionModel<String, AlbumCoverCellViewModel>
    typealias AlbumCoverDataSource = RxCollectionViewSectionedReloadDataSource<AlbumsCoverSectionModel>
    
    struct Dependency {
        let albumRepository: AlbumRepository
    }
    
    struct Input {
        let selectAlbum = PublishRelay<IndexPath>()
        let back = PublishRelay<Void>()
        let edit = PublishRelay<Void>()
    }
    
    struct Output {
        private let disposeBag = DisposeBag()
        let isEdit: BehaviorRelay<Bool> = .init(value: false)
        let albumSection: BehaviorRelay<[AlbumsCoverSectionModel]> = .init(value: [])
        let back: Observable<Void>
        let selectedAlbumsID: BehaviorRelay<[Int]> = .init(value: [])
        
        init(input: Input, dependency: Dependency) {
            Observable.combineLatest(dependency.albumRepository.completeAlbums, isEdit, selectedAlbumsID)
                .map { (albums, isEdit, ids) in
                    [.init(model: "", items: albums.map { .init(dependency: .init(albumViewModel: .init(album: $0), isEdit: isEdit, isSelected: ids.contains($0.uid))) })]
//                    [.init(model: "", items: albums.map { .init(dependency: .init(albumViewModel: AlbumViewModel(album: $0), isEdit: isEdit, isSelected: ids.contains($0.uid))) })]
                }
                .bind(to: albumSection)
                .disposed(by: disposeBag)
            
            back = input.back
                .asObservable()
            
            isEdit
                .filter({ !$0 })
                .map { _ in [] }
                .bind(to: selectedAlbumsID)
                .disposed(by: disposeBag)
            
            bindAction(input, dependency)
        }
        
        private func bindAction(_ input: Input, _ dependency: Dependency) {
            input.edit
                .map { _ in !isEdit.value }
                .bind(to: isEdit)
                .disposed(by: disposeBag)
            
            input.selectAlbum
                .map { $0.item }
                .map(dependency.albumRepository.pickCompleteAlbum(_:))
                .map { viewModel in
                    var ids = selectedAlbumsID.value
                    if ids.contains(viewModel.id),
                       let index = ids.firstIndex(where: { $0 == viewModel.id }) {
                        ids.remove(at: index)
                    } else {
                        ids.append(viewModel.id)
                    }
                    return ids
                }
                .bind(to: selectedAlbumsID)
                .disposed(by: disposeBag)
        }
    }
}
