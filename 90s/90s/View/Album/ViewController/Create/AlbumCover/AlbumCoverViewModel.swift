//
//  AlbumCreateCoverViewModel.swift
//  90s
//
//  Created by 김진우 on 2021/04/18.
//

import Foundation

import RxSwift
import RxRelay
import RxDataSources

final class AlbumCoverViewModel: ViewModelType {

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
    func viewModelForCreateNameAlbum() -> AlbumNameViewModel {
        let viewModel = AlbumNameViewModel(dependency: .init(albumCreate: output.albumCreate))
        return viewModel
    }
}

extension AlbumCoverViewModel {
    typealias CoverSectionModel = SectionModel<String, CoverViewModel>
    
    struct Dependency {
        let coverService: CoverService
        let albumRepository: AlbumRepository
    }
    
    struct Input {
        let selectCover = PublishRelay<IndexPath>()
        let next = PublishRelay<Void>()
        let close = PublishRelay<Void>()
    }
    
    struct Output {
        let coverSection: Observable<[CoverSectionModel]>
        let selectedCover: Observable<Cover>
        let next: Observable<Void>
        let close: Observable<Void>
        let albumCreate: AlbumCreate = .init()
        
        private let disposeBag = DisposeBag()
        
        init(input: Input, dependency: Dependency) {
            selectedCover = input.selectCover
                .map { dependency.coverService.pickCover($0.item) }
            
            coverSection = Observable.just(dependency.coverService.all())
                .map { [.init(model: "", items: $0.map { .init(albumCover: $0) })] }
            
            next = input.next
                .asObservable()
            
            close = input.close
                .asObservable()
            
            selectedCover
                .bind(to: albumCreate.cover)
                .disposed(by: disposeBag)
            
            dependency.albumRepository.event
                .bind { event in
                    print(event)
                }
                .disposed(by: disposeBag)
        }
    }
}
