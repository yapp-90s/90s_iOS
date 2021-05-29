//
//  AlbumViewModel.swift
//  90s
//
//  Created by 김진우 on 2021/03/27.
//

import RxSwift
import RxCocoa

protocol AlbumViewModelOutput {
    var user: Observable<[String]?> { get }
    var name: Observable<String?> { get }
    var date: Observable<String?> { get }
    var maxCount: Observable<Int?> { get }
    var cover: Observable<AlbumCover?> { get }
    var photos: Observable<[Photo]?> { get }
}

protocol AlbumViewModelInput {
//    var updateAlbum: PublishRelay<Album> { get }
}

final class AlbumViewModel: AlbumViewModelOutput, AlbumViewModelInput {
    // MARK: - Output
    var user: Observable<[String]?>
    var name: Observable<String?>
    var date: Observable<String?>
    var maxCount: Observable<Int?>
    var cover: Observable<AlbumCover?>
    var photos: Observable<[Photo]?>
                                                
    // MARK: - Intput
    let id: String
    let disposeBag = DisposeBag()
    let updateAlbum = PublishRelay<Album>()
    
    init(album: Album) {
        self.id = album.id
        
        AlbumProvider.addAndUpdate(album)
        let albumObserver = AlbumProvider.observable(id: id)
            .asObservable()
            .share(replay: 1, scope: .whileConnected)
        
        self.user = albumObserver
            .map { $0?.user }
        self.name = albumObserver
            .map { $0?.name }
        self.date = albumObserver
            .map { $0?.updatedAt }
        self.maxCount = albumObserver
            .map { $0?.totalPaper }
        self.cover = albumObserver
            .map { $0?.cover }
        self.photos = albumObserver
            .map { $0?.photos }
    }
    
    deinit {
        AlbumProvider.release(id: id)
    }
}

