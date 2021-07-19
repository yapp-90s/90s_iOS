//
//  FilmsViewModel.swift
//  90s
//
//  Created by 성다연 on 2021/07/19.
//

import RxSwift
import RxCocoa

final class FilmViewModel : ViewModelType {
    private(set) var dependency : Dependency
    private(set) var input = Input()
    private(set) var output = Output()
    
    let disposeBag = DisposeBag()
    
    init(dependency : Dependency) {
        self.dependency = dependency
    }
    
    init(repository : FilmRepository) {
        self.dependency = Dependency(film: repository.films)
    }
    
    deinit {
        
    }
}

extension FilmViewModel {
    struct Dependency {
        var film : Observable<[FilmsViewModel]>?
    }
    struct Input {
        let inputFilm = PublishRelay<Film>()
    }
    struct Output {
        var outputFilm : Driver<Film>?
    }
}
