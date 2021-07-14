//
//  PhotoViewModel.swift
//  90s
//
//  Created by 성다연 on 2021/02/15.
//

import Foundation
import RxSwift
import RxCocoa
import RxRelay

final class PhotoViewModel : ViewModelType {
    private(set) var dependency: Dependency
    private(set) var input = Input()
    private(set) var output = Output()
    
    var disposeBag = DisposeBag()
    
    required init(dependency: Dependency) {
        self.dependency = dependency
        
        input.newPhoto
            .bind(to: output.photoViewModel)
            .disposed(by: disposeBag)
        
        output.photoSectionViewModel.accept([FilmMainSectionModel(header: "", items: setMockData())])
        
        output.photoViewModel.accept(setMockData())
    }
    
    private func setMockData() -> [Photo] {
        return [
            Photo(photoUid: 0, url: "test_pic1", date: "0"),
            Photo(photoUid: 1, url: "test_pic2", date: "0"),
            Photo(photoUid: 2, url: "test_pic3", date: "0"),
            Photo(photoUid: 3, url: "test_pic4", date: "0"),
            Photo(photoUid: 4, url: "test_pic1", date: "0"),
            Photo(photoUid: 5, url: "test_pic2", date: "0"),
            Photo(photoUid: 6, url: "test_pic3", date: "0"),
            Photo(photoUid: 7, url: "test_pic4", date: "0"),
        ]
    }
}

extension PhotoViewModel {
    struct Dependency {
    }
    
    struct Input {
        var newPhoto = PublishSubject<[Photo]>()
    }
    
    struct Output {
        var photoSectionViewModel : BehaviorRelay<[FilmMainSectionModel]> = .init(value: [])
        var photoViewModel : BehaviorRelay<[Photo]> = .init(value: [])
    }
}


