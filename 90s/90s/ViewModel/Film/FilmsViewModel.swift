//
//  FilmViewModel.swift
//  90s
//
//  Created by 성다연 on 2021/02/15.
//

import Foundation
import RxSwift
import RxCocoa

final class FilmsViewModel : ViewModelType {
    private(set) var dependency : Dependency
    private(set) var input = Input()
    private(set) var output = Output()
    
    var disposeBag = DisposeBag()
    
    init(dependency : Dependency) {
        self.dependency = dependency
        
        // setMockData
        output.films.accept(FilmFactory().createDefaultData())
    }
    
    init(films : Film) {
        self.dependency = Dependency(film: films)
        
        if let f = dependency.film {
            output.films.accept([f])
        }
    }
    
    func getStateData(state : FilmStateType) -> [Film]{
        var array : [Film] = []
        
        output.films
            .map { $0.filter { $0.state == state }}
            .subscribe(onNext: {
                array.append(contentsOf: $0)
            })
            .dispose()
        
        return array
    }
}


extension FilmsViewModel {
    struct Dependency {
        var film : Film?
    }
    struct Input {
        var selectFilm = PublishSubject<Film>()
    }
    struct Output {
        var films = BehaviorRelay<[Film]>(value: [])
    }
}
