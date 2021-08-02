//
//  FilmRepository.swift
//  90s
//
//  Created by 성다연 on 2021/06/16.
//

import RxSwift
import RxRelay

final class FilmRepository {
    static let shared = FilmRepository()
    
    private let filmsRelay = BehaviorRelay<[Film]>(value: [])
    let films : Observable<[FilmsViewModel]>
    
    private init() {
        films = filmsRelay.asObservable().map {
            $0.map { FilmsViewModel(films: $0) }}
        
        filmsRelay.accept(FilmFactory().createDefaultData())
    }
    
    func add(film: Film) {
        var films = filmsRelay.value
        films.insert(film, at: 0)
        filmsRelay.accept(films)
    }
    
    func delete(film: Film) {
        var films = filmsRelay.value
        films.removeAll(where: { $0 == film})
        filmsRelay.subscribe().disposed(by: DisposeBag())
        filmsRelay.accept(films)
    }
}
