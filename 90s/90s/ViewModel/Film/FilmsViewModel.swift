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
    
    var filmService : FilmService {
        return self.dependency.filmService
    }
    
    let disposeBag = DisposeBag()
    
    init(dependency : Dependency) {
        self.dependency = dependency
        
        requestGetFilmList()
    }
    
    func requestCreateFilm(filmCode: Int, filmName: String) {
        self.filmService.create(filmCode: filmCode, filmName: filmName)
            .subscribe({ [weak self] result in
                switch result {
                case .success(let film):
                    self?.output.films.onNext([film.film])
                case .failure(let error):
                    print("❌ API Error - FilmsViewModel : \(error.localizedDescription)")
                }
            }).disposed(by: disposeBag)
    }
    
    func requestGetFilmList() {
        let createFilm : Film = .init(filmUid: -1, name: "필름 만들기", filmCode: -1, photos: [])
        
        self.filmService.getFilmList()
            .subscribe({ [weak self] result in
                switch result {
                case .success(let list):
                    var filmArray : [Film] = []
                    var photoArray : [Photo] = []
                    
                    filmArray.append(createFilm)
                    filmArray.append(contentsOf: list.map { $0.film })
                    photoArray.append(contentsOf: list.map {$0.film.photos}.reduce([], +))
                    
                    self?.output.films.onNext(filmArray)
                    self?.output.photos.onNext(photoArray)
                    self?.bindFilmListSection(filmList: list.map { $0.film })
                    
                case .failure(let error):
                    print("❌ API Error - FilmsViewModel : \(error.localizedDescription)")
                }
            }).disposed(by: disposeBag)
    }
    
    func requestStartPrinting(filmUid: Int) {
        self.filmService.startPrinting(filmUid: filmUid)
            .subscribe({ result in
                switch result {
                case .success(let value):
                    print("Film - request startPrinting : \(value)")
                case .failure(let error):
                    print("❌ API Error: - FilmsViewModel : \(error.localizedDescription)")
                }
            }).disposed(by: disposeBag)
    }
    
    func requestDelete(filmUid: Int) {
        self.filmService.delete(filmUid: filmUid)
            .subscribe({ result in
                switch result {
                case .success(let value):
                    print("Film - request delete : \(value)")
                case .failure(let error):
                    print("❌ API Error: - FilmsViewModel : \(error.localizedDescription)")
                }
            }).disposed(by: disposeBag)
    }
    
    private func bindFilmListSection(filmList : [Film]) {
        var filmSectionList : [FilmSectionModel] = []
        var addArray = FilmSectionModel.init(items: [])
        var timeArray = FilmSectionModel.init(items: [])
        var printArray = FilmSectionModel.init(items: [])
        var completeArray = FilmSectionModel.init(items: [])
        
        filmList.forEach { film in
            var new : FilmSectionItem
            
            switch film.filmState {
            case .create:
                break
            case .adding:
                new = .statusAdding(film: film)
                addArray.items.append(new)
            case .timeprint:
                new = .statusTimeToPrint(film: film)
                timeArray.items.append(new)
            case .printing:
                new = .statusPrinting(film: film)
                printArray.items.append(new)
            case .complete:
                new = .statusCompleted(film: film)
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
        
        output.sectionArray.onNext(filmSectionList)
    }
}


extension FilmsViewModel {
    struct Dependency {
        let filmService = FilmService()
//        let filmFactory = FilmFactory().createDefaultUserData()
    }
    struct Input {
        var selectFilm = PublishSubject<Film>()
    }
    struct Output {
        var sectionArray = PublishSubject<[FilmSectionModel]>()
        var films = PublishSubject<[Film]>()
        var photos = PublishSubject<[Photo]>()
    }
}
