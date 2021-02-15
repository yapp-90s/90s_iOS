//
//  FilmViewModel.swift
//  90s
//
//  Created by 성다연 on 2021/02/15.
//

import Foundation

protocol FilmsViewModelType {
    var inputs : FilmsViewModelInputs { get }
    var outputs : FilmsViewModelOutputs { get }
}

protocol FilmsViewModelInputs {
    
}

protocol FilmsViewModelOutputs {
    
}



class FilmsViewModel : FilmsViewModelType, FilmsViewModelInputs, FilmsViewModelOutputs {
    private(set) var array : [TestFilm] = []
    
    var inputs: FilmsViewModelInputs { return self }
    var outputs: FilmsViewModelOutputs { return self }
    
    init() {
        setDefaultData()
    }
    
    func setDefaultData(){
        self.array = [
            TestFilm(filmName: "필름만들기", filmImage: "newfilmimg") ,
            TestFilm(filmName: "귀여운필름", filmImage: "filmimg", filmType: FilmType.Cute),
            TestFilm(filmName: "멋있는필름", filmImage: "filmimg", filmType: FilmType.Nice),
            TestFilm(filmName: "차가운필름", filmImage: "filmimg", filmType: FilmType.Cold),
            TestFilm(filmName: "차분한필름", filmImage: "filmimg", filmType: FilmType.Dandy)
        ]
    }
}
