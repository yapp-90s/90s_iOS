//
//  FilmViewModel.swift
//  90s
//
//  Created by 성다연 on 2021/02/15.
//

import Foundation
import RxSwift
import RxCocoa

class FilmsViewModel {
    var FilmObservable = BehaviorRelay<[Film]>(value: [])
    
    lazy var itemCount = FilmObservable.map {
        $0.map { $0.name }.count
    }
    
    init() {
        self.setObservableDefaultData()
    }
    
    func getStateData(state : FilmStateType) -> [Film]{
        var array : [Film] = []
        
        FilmObservable
            .map {
                $0.filter { $0.state == state }
            }.subscribe(onNext: {
                array.append(contentsOf: $0)
            })
            .dispose()
        
        return array
    }

    func setObservableDefaultData(){
        let filmArray = [
            Film(id: "0", name: "필름 만들기", completeDate: "2021.10.10", filterType: .Create, photos: [
                Photo(id: "0000", url: "picture1", date: "\(Date())"),
                Photo(id: "0000", url: "picture1", date: "\(Date())"),
                Photo(id: "0000", url: "picture1", date: "\(Date())")
            ]
            , maxCount: 36, state: .create),
            Film(id: "1", name: "귀여운 필름", completeDate: "2021.10.10", filterType: .Cute, photos: [
                        Photo(id: "0001", url: "picture1", date: "\(Date())"),
                        Photo(id: "0002", url: "picture1", date: "\(Date())"),
                        Photo(id: "0003", url: "picture1", date: "\(Date())")
                    ]
                 , maxCount: 36, state: .adding),
            Film(id: "2", name: "멋있는 필름", completeDate: "2021.10.10", filterType: .Nice, photos: [
                        Photo(id: "0004", url: "picture2", date: "\(Date())"),
                        Photo(id: "0005", url: "picture2", date: "\(Date())"),
                        Photo(id: "0006", url: "picture2", date: "\(Date())")
                    ]
                 , maxCount: 36, state: .adding),
            Film(id: "3", name: "차가운 필름", completeDate: "2021.10.10", filterType: .Cold, photos: [
                        Photo(id: "0007", url: "picture4", date: "\(Date())"),
                        Photo(id: "0008", url: "picture4", date: "\(Date())"),
                        Photo(id: "0009", url: "picture4", date: "\(Date())")
                    ]
            , maxCount: 36, state: .printing),
            Film(id: "4", name: "차분한 필름", completeDate: "2021.10.10", filterType: .Dandy, photos: [
                        Photo(id: "0010", url: "picture3", date: "\(Date())"),
                        Photo(id: "0011", url: "picture3", date: "\(Date())"),
                        Photo(id: "0012", url: "picture3", date: "\(Date())")
                    ]
                 , maxCount: 36, state: .printing),
            Film(id: "5", name: "생생한 필름", completeDate: "2021.10.10", filterType: .Nice, photos: [
                        Photo(id: "0013", url: "picture1", date: "\(Date())"),
                        Photo(id: "0014", url: "picture1", date: "\(Date())"),
                        Photo(id: "0015", url: "picture1", date: "\(Date())")
                    ]
                 , maxCount: 36, state: .complete),
            Film(id: "6", name: "귀여운 필름", completeDate: "2021.10.10", filterType: .Cute, photos: [], maxCount: 36, state: .adding),
        ]
        
        FilmObservable.accept(filmArray)
    }
}
