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
        
        var filmSectionList : [FilmSectionModel] = []
        
        var addArray = FilmSectionModel.init(items: [])
        var timeArray = FilmSectionModel.init(items: [])
        var printArray = FilmSectionModel.init(items: [])
        var completeArray = FilmSectionModel.init(items: [])
    
        dependency.filmFactory.forEach { film in
            var new : FilmSectionItem
            switch film.filmState {
            case .create: break
            case .adding:
                new = .statusAdding(films: film)
                addArray.items.append(new)
            case .timeprint:
                new = .statusTimeToPrint(film: film)
                timeArray.items.append(new)
            case .printing:
                new = .statusTimeToPrint(film: film)
                printArray.items.append(new)
            case .complete:
                new = .statusCompleted(films: film)
                completeArray.items.append(new)
            }
        }

        if !timeArray.items.isEmpty {
            filmSectionList.append(timeArray)
        }
        if !addArray.items.isEmpty {
            filmSectionList.append(addArray)
        }
        if !printArray.items.isEmpty {
            filmSectionList.append(printArray)
        }
        if !completeArray.items.isEmpty {
            filmSectionList.append(completeArray)
        }
        
        output.filmSectionViewModel.accept(filmSectionList)
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
        var filmSectionViewModel = BehaviorRelay<[FilmSectionModel]>(value: [])
    }
}
