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
            .bind(to: output.photoSectionViewModel)
            .disposed(by: disposeBag)
        
        output.photoSectionViewModel.accept([FilmMainSectionModel(header: "", items: setMockData())])
    }
    
    private func setMockData() -> [Photo] {
        return [
            Photo(photoUid: 0, filmUid: -10, url: "test_pic1"),
            Photo(photoUid: 1, filmUid: -10, url: "test_pic2"),
            Photo(photoUid: 2, filmUid: -10, url: "test_pic3"),
            Photo(photoUid: 3, filmUid: -10, url: "test_pic4"),
            Photo(photoUid: 4, filmUid: -10, url: "test_pic1"),
            Photo(photoUid: 5, filmUid: -10, url: "test_pic2"),
            Photo(photoUid: 6, filmUid: -10, url: "test_pic3"),
            Photo(photoUid: 7, filmUid: -10, url: "test_pic4"),
            Photo(photoUid: 8, filmUid: -10, url: "test_pic1"),
            Photo(photoUid: 9, filmUid: -10, url: "test_pic2"),
            Photo(photoUid: 10, filmUid: -10, url: "test_pic3"),
        ]
    }
}

extension PhotoViewModel {
    struct Dependency {
    }
    
    struct Input {
        var newPhoto = PublishSubject<[FilmMainSectionModel]>()
    }
    
    struct Output {
        var photoSectionViewModel : BehaviorRelay<[FilmMainSectionModel]> = .init(value: [])
    }
}


