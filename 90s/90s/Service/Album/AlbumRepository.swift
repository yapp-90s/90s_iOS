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
<<<<<<< HEAD
        var dummyAlbums: [Album] = [
            .init(id: UUID().uuidString, user: ["A"], name: "앨범1", createdAt: "", updatedAt: "", completedAt: "", totalPaper: 0, cover: .empty, photos: [
                .init(photoUid: 0, filmUid: -100, url: ""),
                .init(photoUid: 1, filmUid: -100, url: ""),
                .init(photoUid: 2, filmUid: -100, url: "")
            ]),
            .init(id: UUID().uuidString, user: ["A"], name: "앨범1", createdAt: "", updatedAt: "", completedAt: "", totalPaper: 0, cover: .empty, photos: [
                .init(photoUid: 3, filmUid: -101, url: ""),
                .init(photoUid: 4, filmUid: -101, url: ""),
                .init(photoUid: 5, filmUid: -101, url: ""),
                .init(photoUid: 6, filmUid: -101, url: "")
            ]),
            .init(id: UUID().uuidString, user: ["A"], name: "앨범1", createdAt: "", updatedAt: "", completedAt: "", totalPaper: 0, cover: .empty, photos: [
                .init(photoUid: 7, filmUid: -102, url: ""),
                .init(photoUid: 8, filmUid: -102, url: "")
            ]),
            .init(id: UUID().uuidString, user: ["A"], name: "앨범1", createdAt: "", updatedAt: "", completedAt: "", totalPaper: 0, cover: .empty, photos: [
                .init(photoUid: 9, filmUid: -103, url: ""),
                .init(photoUid: 10, filmUid: -103, url: ""),
                .init(photoUid: 11, filmUid: -103, url: ""),
                .init(photoUid: 12, filmUid: -103, url: "")
            ]),
            .init(id: UUID().uuidString, user: ["A"], name: "앨범1", createdAt: "", updatedAt: "", completedAt: "", totalPaper: 0, cover: .empty, photos: [
                .init(photoUid: 13, filmUid: -104, url: "")
            ]),
            .init(id: UUID().uuidString, user: ["A"], name: "앨범1", createdAt: "", updatedAt: "", completedAt: "", totalPaper: 0, cover: .empty, photos: [
                .init(photoUid: 14, filmUid: -105, url: ""),
                .init(photoUid: 15, filmUid: -106, url: ""),
                .init(photoUid: 16, filmUid: -107, url: ""),
                .init(photoUid: 17, filmUid: -108, url: "")
            ])
        ]
        dummyAlbums.sort { (l, r) -> Bool in
            return l.createdAt < r.createdAt
=======
        queue.sync {
            var dummyAlbums: [Album] = [
                .init(id: UUID().uuidString, user: ["A"], name: "앨범1", createdAt: "", updatedAt: "", completedAt: "", totalPaper: 0, cover: .sweetLittleMemories, photos: [
                    .init(photoUid: 0, url: "", date: "2020.01.03"),
                    .init(photoUid: 1, url: "", date: "2020.01.04"),
                    .init(photoUid: 2, url: "", date: "2020.01.05")
                ]),
                .init(id: UUID().uuidString, user: ["A"], name: "앨범1", createdAt: "", updatedAt: "", completedAt: "", totalPaper: 0, cover: .candy, photos: [
                    .init(photoUid: 3, url: "", date: "2020.01.03"),
                    .init(photoUid: 4, url: "", date: "2020.01.03"),
                    .init(photoUid: 5, url: "", date: "2020.01.03"),
                    .init(photoUid: 6, url: "", date: "2020.01.03")
                ]),
                .init(id: UUID().uuidString, user: ["A"], name: "앨범1", createdAt: "", updatedAt: "", completedAt: "", totalPaper: 0, cover: .yic, photos: [
                    .init(photoUid: 7, url: "", date: "2020.01.03"),
                    .init(photoUid: 8, url: "", date: "2020.01.03")
                ]),
                .init(id: UUID().uuidString, user: ["A"], name: "앨범1", createdAt: "", updatedAt: "", completedAt: "", totalPaper: 0, cover: .stickyBubble, photos: [
                    .init(photoUid: 9, url: "", date: "2020.01.03"),
                    .init(photoUid: 10, url: "", date: "2020.01.03"),
                    .init(photoUid: 11, url: "", date: "2020.01.03"),
                    .init(photoUid: 12, url: "", date: "2020.01.03")
                ]),
                .init(id: UUID().uuidString, user: ["A"], name: "앨범1", createdAt: "", updatedAt: "", completedAt: "", totalPaper: 0, cover: .youMakeMeCloudy, photos: [
                    .init(photoUid: 13, url: "", date: "2020.01.03")
                ]),
                .init(id: UUID().uuidString, user: ["A"], name: "앨범1", createdAt: "", updatedAt: "", completedAt: "", totalPaper: 0, cover: .sweetLittleMemories, photos: [
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
            let makingAlbums = makingAlbumsRelay.value
            return .init(album: makingAlbums[index])
        }
    }
    
    func add(albumCreate: AlbumCreate) -> Bool {
        queue.sync {
            let album = Album(id: "", name: albumCreate.name.value, createdAt: "albumCreate.date.value", updatedAt: "albumCreate.date.value", totalPaper: 10, cover: albumCreate.cover.value)
            var albums = albumsRelay.value
            albums.insert(album, at: 0)
            albumsRelay.accept(albums)
            event.onNext(.add)
            return true
>>>>>>> cb4e569fdf1cc7bbe4d69eac9177eaa892d2ae28
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
