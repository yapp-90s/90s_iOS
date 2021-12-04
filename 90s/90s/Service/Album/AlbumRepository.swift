//
//  AlbumRepository.swift
//  90s
//
//  Created by 김진우 on 2021/05/13.
//

import RxSwift
import RxRelay

enum AlbumEvent {
    case add
    case update
    case delete
    case refresh
}

final class AlbumRepository {
    
    static let shared = AlbumRepository()
    
    private let queue = DispatchQueue(label: "AlbumRepository", qos: .utility)
    private let makingAlbumsRelay = BehaviorRelay<[Album]>(value: []) // Legacy
    private let client: AlbumClientStub = .shared
    private let disposeBag = DisposeBag()
    
    private let albumsRelay = BehaviorRelay<[Album]>(value: [])
    
    // MARK: - Input
    let requestAll: PublishRelay<Void> = .init()
    let create: PublishRelay<AlbumCreate> = .init()
    let addPhoto: PublishRelay<Photo> = .init()
    let complete: PublishRelay<String> = .init()
    let delete: PublishRelay<String> = .init()
    
    // MARK: - Output
    let event = PublishSubject<AlbumEvent>()
    let albums: Observable<[AlbumViewModel]>
    let allAlbums: Observable<[Album]>
    let completeAlbums: Observable<[Album]>
    let makeingAlbums: Observable<[Album]>
    
    private init() {
        albums = albumsRelay // Legacy
            .asObservable()
            .map { $0.map { AlbumViewModel(album: $0)} }
            .subscribeOn(SerialDispatchQueueScheduler(queue: queue, internalSerialQueueName: UUID().uuidString))
        
        allAlbums = albumsRelay
            .asObservable()
            .subscribeOn(SerialDispatchQueueScheduler(queue: queue, internalSerialQueueName: UUID().uuidString))
        
        completeAlbums = allAlbums
            .map { $0.filter { $0.completedAt != nil } }
        
        makeingAlbums = allAlbums
            .map { $0.filter { $0.completedAt == nil } }
        
        bindAction()
    }
    
    private func bindActionDummy() {
        requestAll
            .map(client.all(_:))
            .bind(to: albumsRelay)
            .disposed(by: disposeBag)
        
        create
            .map(client.create(_:))
            .filter { $0 }
            .map { _ in () }
            .bind(to: requestAll)
            .disposed(by: disposeBag)
        
        addPhoto
            .map(client.addPhoto(_:))
            .filter { $0 }
            .map { _ in () }
            .bind(to: requestAll)
            .disposed(by: disposeBag)
        
        complete
            .map(client.complte(_:))
            .filter { $0 }
            .map { _ in () }
            .bind(to: requestAll)
            .disposed(by: disposeBag)
        
        delete
            .map(client.delete(_:))
            .filter { $0 }
            .map { _ in () }
            .bind(to: requestAll)
            .disposed(by: disposeBag)
    }
    
    private func bindAction() {
        requestAll
            .map(client.all(_:))
            .bind(to: albumsRelay)
            .disposed(by: disposeBag)
        
        create
            .map(client.create(_:))
            .filter { $0 }
            .map { _ in () }
            .bind(to: requestAll)
            .disposed(by: disposeBag)
        
        addPhoto
            .map(client.addPhoto(_:))
            .filter { $0 }
            .map { _ in () }
            .bind(to: requestAll)
            .disposed(by: disposeBag)
        
        complete
            .map(client.complte(_:))
            .filter { $0 }
            .map { _ in () }
            .bind(to: requestAll)
            .disposed(by: disposeBag)
        
        delete
            .map(client.delete(_:))
            .filter { $0 }
            .map { _ in () }
            .bind(to: requestAll)
            .disposed(by: disposeBag)
    }
    
    private func requestAll(_ void: Void) {
        requestAll.accept(())
    }
    
    func all() -> [Album] {
        queue.sync {
            let albums = albumsRelay.value
            return albums
        }
    }
    
    func pickAlbum(_ index: Int) -> AlbumViewModel {
        queue.sync {
            let albums = albumsRelay.value
            return .init(album: albums[index])
        }
    }
    
    func pickMakingAlbum(_ index: Int) -> AlbumViewModel {
        queue.sync {
            let makingAlbums = albumsRelay.value.filter { $0.completedAt == nil }
            return .init(album: makingAlbums[index])
        }
    }
    
    func pickCompleteAlbum(_ index: Int) -> AlbumViewModel {
        queue.sync {
            let makingAlbums = albumsRelay.value.filter { $0.completedAt != nil }
            return .init(album: makingAlbums[index])
        }
    }
    
    func add(albumCreate: AlbumCreate) -> Bool {
        queue.sync {
            let album = Album(uid: UUID().uuidString, name: albumCreate.name.value, createdAt: albumCreate.date.value.dateToString(), updatedAt: albumCreate.date.value.dateToString(), totalPaper: 10, cover: albumCreate.cover.value)
            var albums = albumsRelay.value
            albums.insert(album, at: 0)
            albumsRelay.accept(albums)
            event.onNext(.add)
            return true
        }
    }
    
    func update(id: String, album: Album) -> Bool {
        queue.sync {
            var albums = albumsRelay.value
            if let index = albums.firstIndex(where: { $0.uid == id }) {
                albums[index] = album
                albumsRelay.accept(albums)
                event.onNext(.update)
                return true
            }
            return false
        }
    }
    
    func delete(id: String) -> Bool {
        queue.sync {
            var albums = albumsRelay.value
            if let index = albums.firstIndex(where: { $0.uid == id }) {
                albums.remove(at: index)
                albumsRelay.accept(albums)
                event.onNext(.delete)
                return true
            }
            return false
        }
    }
    
    
//    private func fetchMockData() {
//        queue.sync {
//            var dummyAlbums: [Album] = [
//                .init(uid: UUID().uuidString, user: ["A"], name: "앨범1", createdAt: "", updatedAt: "", completedAt: "", totalPaper: 0, cover: .sweetLittleMemories, photos: [
//                    .init(photoUid: 0, url: "", date: "2020.01.03"),
//                    .init(photoUid: 1, url: "", date: "2020.01.04"),
//                    .init(photoUid: 2, url: "", date: "2020.01.05")
//                ]),
//                .init(uid: UUID().uuidString, user: ["A"], name: "앨범1", createdAt: "", updatedAt: "", completedAt: "", totalPaper: 0, cover: .candy, photos: [
//                    .init(photoUid: 3, url: "", date: "2020.01.03"),
//                    .init(photoUid: 4, url: "", date: "2020.01.03"),
//                    .init(photoUid: 5, url: "", date: "2020.01.03"),
//                    .init(photoUid: 6, url: "", date: "2020.01.03")
//                ]),
//                .init(uid: UUID().uuidString, user: ["A"], name: "앨범1", createdAt: "", updatedAt: "", completedAt: "", totalPaper: 0, cover: .yic, photos: [
//                    .init(photoUid: 7, url: "", date: "2020.01.03"),
//                    .init(photoUid: 8, url: "", date: "2020.01.03")
//                ]),
//                .init(uid: UUID().uuidString, user: ["A"], name: "앨범1", createdAt: "", updatedAt: "", completedAt: "", totalPaper: 0, cover: .stickyBubble, photos: [
//                    .init(photoUid: 9, url: "", date: "2020.01.03"),
//                    .init(photoUid: 10, url: "", date: "2020.01.03"),
//                    .init(photoUid: 11, url: "", date: "2020.01.03"),
//                    .init(photoUid: 12, url: "", date: "2020.01.03")
//                ]),
//                .init(uid: UUID().uuidString, user: ["A"], name: "앨범1", createdAt: "", updatedAt: "", completedAt: "", totalPaper: 0, cover: .youMakeMeCloudy, photos: [
//                    .init(photoUid: 13, url: "", date: "2020.01.03")
//                ]),
//                .init(uid: UUID().uuidString, user: ["A"], name: "앨범1", createdAt: "", updatedAt: "", completedAt: "", totalPaper: 0, cover: .sweetLittleMemories, photos: [
//                    .init(photoUid: 14, url: "", date: "2020.01.03"),
//                    .init(photoUid: 15, url: "", date: "2020.01.03"),
//                    .init(photoUid: 16, url: "", date: "2020.01.03"),
//                    .init(photoUid: 17, url: "", date: "2020.01.03")
//                ])
//            ]
//            dummyAlbums.sort { (l, r) -> Bool in
//                return l.createdAt < r.createdAt
//            }
//            albumsRelay.accept(dummyAlbums)
//        }
//    }
}
