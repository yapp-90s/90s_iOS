//
//  FilmListViewModel.swift
//  90s
//
//  Created by 성다연 on 2021/08/02.
//

import Foundation
import RxSwift
import RxCocoa

final class FilmListViewModel : ViewModelType {
    private(set) var dependency : Dependency
    private(set) var input = Input()
    private(set) var output = Output()
    
    let disposeBag = DisposeBag()
    
    init(dependency: Dependency) {
        self.dependency = dependency
        
        bind()
    }
    
    private func bind() {
        FilmRepository.shared.films.bind(to: input.filmsViewModel).disposed(by: disposeBag)
        
        FilmRepository.shared.films.map { films in
            films.flatMap { $0.getStateData(state: .printing).filter { $0.printStartAt == nil }}
        }.bind(to: output.film_timeToPrint)
        .disposed(by: disposeBag)

        FilmRepository.shared.films.map { films in
            films.flatMap { $0.getStateData(state: .adding)}
        }.bind(to: output.film_adding)
        .disposed(by: disposeBag)

        FilmRepository.shared.films.map { films in
            films.flatMap { $0.getStateData(state: .printing)}
        }.bind(to: output.film_printing)
        .disposed(by: disposeBag)

        FilmRepository.shared.films.map { films in
            films.flatMap { $0.getStateData(state: .complete)}
        }.bind(to: output.film_complete)
        .disposed(by: disposeBag)
        
        var filmList : [FilmStateType : Film?] = [
            .create : nil,
            .adding : nil,
            .printing : nil,
            .complete : nil
        ]
        
        dependency.filmFactory.forEach { film in
            filmList.updateValue(film, forKey: film.filmState)
        }
        output.filmSectionViewModel.accept(filmList)
    }
}

extension FilmListViewModel {
    struct Dependency {
        let filmFactory = FilmFactory().createDefaultUserData()
    }
    struct Input {
        var filmsViewModel = PublishSubject<[FilmsViewModel]>()
    }
    struct Output {
        var filmSectionViewModel = BehaviorRelay<[FilmStateType : Film?]>(value: [:])
        let film_timeToPrint = BehaviorSubject<[Film]>(value: [])
        let film_adding = BehaviorSubject<[Film]>(value: [])
        let film_printing = BehaviorSubject<[Film]>(value: [])
        let film_complete = BehaviorSubject<[Film]>(value: [])
    }
}
