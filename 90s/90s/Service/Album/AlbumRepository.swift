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
    private let albumsRelay = BehaviorRelay<[Album]>(value: [])
    private let makingAlbumsRelay = BehaviorRelay<[Album]>(value: [])
    let albums: Observable<[AlbumViewModel]>
    let event = PublishSubject<AlbumEvent>()
    
    private init() {
        albums = albumsRelay
            .asObservable()
            .map { $0.map { AlbumViewModel(album: $0)} }
            .subscribeOn(SerialDispatchQueueScheduler(queue: queue, internalSerialQueueName: UUID().uuidString))
        
        fetchMockData()
    }
    
    private func fetchMockData() {
        queue.sync {
            var dummyAlbums: [Album] = [
                .init(id: UUID().uuidString, user: ["A"], name: "앨범1", createdAt: "", updatedAt: "", completedAt: "", totalPaper: 0, cover: .empty, photos: [
                    .init(photoUid: 0, url: "", date: "2020.01.03"),
                    .init(photoUid: 1, url: "", date: "2020.01.04"),
                    .init(photoUid: 2, url: "", date: "2020.01.05")
                ]),
                .init(id: UUID().uuidString, user: ["A"], name: "앨범1", createdAt: "", updatedAt: "", completedAt: "", totalPaper: 0, cover: .empty, photos: [
                    .init(photoUid: 3, url: "", date: "2020.01.03"),
                    .init(photoUid: 4, url: "", date: "2020.01.03"),
                    .init(photoUid: 5, url: "", date: "2020.01.03"),
                    .init(photoUid: 6, url: "", date: "2020.01.03")
                ]),
                .init(id: UUID().uuidString, user: ["A"], name: "앨범1", createdAt: "", updatedAt: "", completedAt: "", totalPaper: 0, cover: .empty, photos: [
                    .init(photoUid: 7, url: "", date: "2020.01.03"),
                    .init(photoUid: 8, url: "", date: "2020.01.03")
                ]),
                .init(id: UUID().uuidString, user: ["A"], name: "앨범1", createdAt: "", updatedAt: "", completedAt: "", totalPaper: 0, cover: .empty, photos: [
                    .init(photoUid: 9, url: "", date: "2020.01.03"),
                    .init(photoUid: 10, url: "", date: "2020.01.03"),
                    .init(photoUid: 11, url: "", date: "2020.01.03"),
                    .init(photoUid: 12, url: "", date: "2020.01.03")
                ]),
                .init(id: UUID().uuidString, user: ["A"], name: "앨범1", createdAt: "", updatedAt: "", completedAt: "", totalPaper: 0, cover: .empty, photos: [
                    .init(photoUid: 13, url: "", date: "2020.01.03")
                ]),
                .init(id: UUID().uuidString, user: ["A"], name: "앨범1", createdAt: "", updatedAt: "", completedAt: "", totalPaper: 0, cover: .empty, photos: [
                    .init(photoUid: 14, url: "", date: "2020.01.03"),
                    .init(photoUid: 15, url: "", date: "2020.01.03"),
                    .init(photoUid: 16, url: "", date: "2020.01.03"),
                    .init(photoUid: 17, url: "", date: "2020.01.03")
                ])
            ]
            dummyAlbums.sort { (l, r) -> Bool in
                return l.createdAt < r.createdAt
            }
            albumsRelay.accept(dummyAlbums)
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
            let makingAlbums = makingAlbumsRelay.value
            return .init(album: makingAlbums[index])
        }
    }
    
    func add(album: Album) -> Bool {
        queue.sync {
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
            if let index = albums.firstIndex(where: { $0.id == id }) {
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
            if let index = albums.firstIndex(where: { $0.id == id }) {
                albums.remove(at: index)
                albumsRelay.accept(albums)
                event.onNext(.delete)
                return true
            }
            return false
        }
    }
}
