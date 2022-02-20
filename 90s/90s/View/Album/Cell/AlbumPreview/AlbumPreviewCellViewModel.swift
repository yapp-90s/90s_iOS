//
//  AlbumPreviewCellViewModel.swift
//  90s
//
//  Created by 김진우 on 2022/02/13.
//

import Foundation

import RxSwift
import RxRelay
import RxDataSources

final class AlbumPreviewCellViewModel: ViewModelType {
    
    private(set) var dependency: Dependency
    private(set) var input: Input
    private(set) var output: Output
    
    let disposeBag = DisposeBag()

    init(dependency: Dependency) {
        self.dependency = dependency
        self.input = .init()
        self.output = .init(input: input, dependency: dependency)
    }
}

extension AlbumPreviewCellViewModel {
    
    struct Dependency {
        let album: Album
    }
    
    struct Input {
    }
    
    struct Output {
        let name: String?
        let image: UIImage?
        let dateString: String?
        let photos: [Photo]
        
        init(input: Input, dependency: Dependency) {
            name = dependency.album.name
            image = dependency.album.cover.image
            dateString = dependency.album.completedAt?.dateString
            photos = dependency.album.photos
        }
    }
}
