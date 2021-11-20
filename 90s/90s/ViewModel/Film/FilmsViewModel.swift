//
//  FilmViewModel.swift
//  90s
//
//  Created by 성다연 on 2021/02/15.
//

import Foundation
import RxSwift
import RxCocoa

/// Usage : FilmMainViewController
final class FilmsViewModel : ViewModelType {
    private(set) var dependency : Dependency
    private(set) var input = Input()
    private(set) var output = Output()
    
    var disposeBag = DisposeBag()
    
    init(dependency : Dependency) {
        self.dependency = dependency
        
        // setMockData
        output.films.accept(dependency.filmFactory)
        
        var photoArray : [Photo] = []
        dependency.filmFactory.forEach { photoArray.append(contentsOf: $0.photos) }
        output.photos.accept(photoArray)
    }
    
    init(films : [Film]) {
        self.dependency = Dependency(films: Observable.from(optional: films))
        
        output.films.accept(films)
        
        var photoArray : [Photo] = []
        films.forEach { photoArray.append(contentsOf: $0.photos)}
        output.photos.accept(photoArray)
    }
    
     func getStateData(state : FilmStateType) -> [Film]{
        var array : [Film] = []
        
        output.films
            .map { $0.filter { $0.filmState == state }}
            .subscribe(onNext: {
                array.append(contentsOf: $0)
            })
            .disposed(by: disposeBag)
        
        return array
    }
}


extension FilmsViewModel {
    struct Dependency {
        weak var films : Observable<[Film]>?
        let filmFactory = FilmFactory().createDefaultUserData()
    }
    struct Input {
        var selectFilm = PublishSubject<Film>()
    }
    struct Output {
        var films = BehaviorRelay<[Film]>(value: [])
        var photos = BehaviorRelay<[Photo]>(value: [])
    }
}
