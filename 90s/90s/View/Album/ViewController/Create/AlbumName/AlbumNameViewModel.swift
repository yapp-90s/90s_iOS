//
//  AlbumCreateNameViewModel.swift
//  90s
//
//  Created by 김진우 on 2021/11/19.
//

import Foundation

import RxSwift
import RxRelay
import RxDataSources

final class AlbumNameViewModel: ViewModelType {
    
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
    func viewModelForAlbumCreateTemplate() -> AlbumTemplateViewModel {
        let viewmodel = AlbumTemplateViewModel(dependency: .init(albumCreate: output.albumCreate))
        return viewmodel
    }
}

extension AlbumNameViewModel {
    struct Dependency {
        let albumCreate: AlbumCreate
    }
    
    struct Input {
        let name = PublishRelay<String>()
        let next = PublishRelay<Void>()
    }
    
    struct Output {
        let albumCreate: AlbumCreate
        let next: Observable<Void>
        
        let disposeBag = DisposeBag()
        
        init(input: Input, dependency: Dependency) {
            self.albumCreate = dependency.albumCreate
            self.next = input.next.asObservable()
            input.name
                .bind(to: albumCreate.name)
                .disposed(by: disposeBag)
        }
    }
}
