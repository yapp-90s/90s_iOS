//
//  GalleryViewModel.swift
//  90s
//
//  Created by 성다연 on 2021/11/13.
//

import Foundation
import RxSwift

class GalleryViewModel : ViewModelType {
    private(set) var dependency: Dependency
    private(set) var input = Input()
    private(set) var output = Output()
    let disposeBag = DisposeBag()
    
    required init(dependency: Dependency) {
        self.dependency = dependency
    }
}

extension GalleryViewModel {
    struct Dependency {
//        weak var filmViewModel : FilmViewModel?
    }
    
    struct Input {
        var selectedFilm = PublishSubject<Film>()
    }
    
    struct Output {
        var selectedImages = PublishSubject<[UIImage]>()
    }
}
