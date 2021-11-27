//
//  AlbumRepository.swift
//  90s
//
//  Created by 김진우 on 2021/05/13.
//

import RxSwift
import RxRelay

final class AlbumRepository {
    
    static let shared = AlbumRepository()
    
    private let albumsRelay = BehaviorRelay<[Album]>(value: [])
    let albums: Observable<[AlbumViewModel]>
    
    private init() {
        albums = albumsRelay
            .asObservable()
            .map { $0.map { AlbumViewModel(album: $0)} }
        
        fetchMockData()
    }
    
    private func fetchMockData() {
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
        }
        albumsRelay.accept(dummyAlbums)
    }
    
    func add(album: Album) {
        var albums = albumsRelay.value
        albums.insert(album, at: 0)
        albumsRelay.accept(albums)
    }
}
