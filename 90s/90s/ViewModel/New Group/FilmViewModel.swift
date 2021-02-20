//
//  FilmViewModel.swift
//  90s
//
//  Created by 성다연 on 2021/02/15.
//

import Foundation
import RxSwift

class FilmsViewModel {
    private(set) var array : [TestFilm] = []
    var FilmObservable = BehaviorSubject<[TestFilm]>(value: [])
    
    lazy var itemCount = FilmObservable.map {
        $0.map { $0.filmName }.count
    }
    
    init() {
        setDefaultData()
        setObservableDefaultData()
    }
    
    func setDefaultData(){
        self.array = [
            TestFilm(filmName: "필름만들기", filmImage: "newfilmimg") ,
            TestFilm(filmName: "귀여운필름", filmImage: "filmimg", filmType: FilmType.Cute),
            TestFilm(filmName: "멋있는필름", filmImage: "filmimg", filmType: FilmType.Nice),
            TestFilm(filmName: "차가운필름", filmImage: "filmimg", filmType: FilmType.Cold),
            TestFilm(filmName: "차분한필름", filmImage: "filmimg", filmType: FilmType.Dandy),
        ]
    }
    
    func setObservableDefaultData(){
        let films = [
            TestFilm(filmName: "필름만들기", filmImage: "newfilmimg") ,
            TestFilm(filmName: "귀여운필름", filmImage: "filmimg", filmType: FilmType.Cute),
            TestFilm(filmName: "멋있는필름", filmImage: "filmimg", filmType: FilmType.Nice),
            TestFilm(filmName: "차가운필름", filmImage: "filmimg", filmType: FilmType.Cold),
            TestFilm(filmName: "차분한필름", filmImage: "filmimg", filmType: FilmType.Dandy),
        ]
        
        FilmObservable.onNext(films)
    }
}
