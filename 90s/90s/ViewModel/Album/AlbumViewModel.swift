//
//  AlbumViewModel.swift
//  90s
//
//  Created by 김진우 on 2021/03/27.
//

import RxSwift
import RxCocoa

protocol AlbumViewModelOutput {
//    var user: Observable<[String]?> { get }
    var name: Observable<String?> { get }
    var date: Observable<String?> { get }
//    var maxCount: Observable<Int?> { get  }
    var cover: Observable<Cover?> { get }
    var photos: Observable<[Photo]?> { get }
}

protocol AlbumViewModelInput {
//    var updateAlbum: PublishRelay<Album> { get }
}

final class AlbumViewModel: AlbumViewModelOutput, AlbumViewModelInput {
    // MARK: - Output
//    var user: Observable<[String]?>
    var name: Observable<String?>
    var date: Observable<String?>
//    var maxCount: Observable<Int?>
    var cover: Observable<Cover?>
    var template: Observable<Template?>
    var photos: Observable<[Photo]?>
    var pages: Observable<[Page]?>
                                                
    // MARK: - Intput
    let id: Int
    let album: Album
    let disposeBag = DisposeBag()
    let updateAlbum = PublishRelay<Album>()
    
    init(album: Album) {
        self.id = album.uid
        self.album = album
        AlbumProvider.addAndUpdate(album)
        let albumObserver = AlbumProvider.observable(id: id)
            .asObservable()
            .share(replay: 1, scope: .whileConnected)
        
//        self.user = albumObserver
//            .map { $0?.user }
        self.name = albumObserver
            .map { $0?.name }
        self.date = albumObserver
            .map { $0?.completedAt }
//        self.maxCount = albumObserver
//            .map { $0?.totalPaper }
        self.cover = albumObserver
            .map { $0?.cover }
        self.template = albumObserver
            .map { $0?.template }
        self.photos = albumObserver
            .map { $0?.photos }
        self.pages = albumObserver
            .map { $0?.pages }
    }
    
    deinit {
        AlbumProvider.release(id: id)
    }
}

