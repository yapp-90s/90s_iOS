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
    
    func add(album: Album) {
        var albums = albumsRelay.value
        albums.insert(album, at: 0)
        albumsRelay.accept(albums)
    }
}
