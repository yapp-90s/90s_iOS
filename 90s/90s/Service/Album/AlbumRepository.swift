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
            .init(id: UUID().uuidString, user: ["A"], name: "앨범1", date: "2020.01.03", maxCount: 10, cover: Copy(), photos: [
                .init(id: UUID().uuidString, url: "", date: "2020.01.03"),
                .init(id: UUID().uuidString, url: "", date: "2020.01.04"),
                .init(id: UUID().uuidString, url: "", date: "2020.01.05")
            ]),
            .init(id: UUID().uuidString, user: ["B"], name: "앨범2", date: "2020.01.03", maxCount: 10, cover: Paradiso(), photos: [
                .init(id: UUID().uuidString, url: "", date: "2020.01.03"),
                .init(id: UUID().uuidString, url: "", date: "2020.01.03"),
                .init(id: UUID().uuidString, url: "", date: "2020.01.03"),
                .init(id: UUID().uuidString, url: "", date: "2020.01.03")
            ]),
            .init(id: UUID().uuidString, user: ["C"], name: "앨범3", date: "2020.01.03", maxCount: 10, cover: HappilyEverAfter(), photos: [
                .init(id: UUID().uuidString, url: "", date: "2020.01.03"),
                .init(id: UUID().uuidString, url: "", date: "2020.01.03")
            ]),
            .init(id: UUID().uuidString, user: ["D"], name: "앨범4", date: "2020.01.03", maxCount: 10, cover: Copy(), photos: [
                .init(id: UUID().uuidString, url: "", date: "2020.01.03"),
                .init(id: UUID().uuidString, url: "", date: "2020.01.03"),
                .init(id: UUID().uuidString, url: "", date: "2020.01.03"),
                .init(id: UUID().uuidString, url: "", date: "2020.01.03")
            ]),
            .init(id: UUID().uuidString, user: ["E"], name: "앨범5", date: "2020.01.03", maxCount: 10, cover: Paradiso(), photos: [
                .init(id: UUID().uuidString, url: "", date: "2020.01.03")
            ]),
            .init(id: UUID().uuidString, user: ["F"], name: "앨범6", date: "2020.01.03", maxCount: 10, cover: HappilyEverAfter(), photos: [
                .init(id: UUID().uuidString, url: "", date: "2020.01.03"),
                .init(id: UUID().uuidString, url: "", date: "2020.01.03"),
                .init(id: UUID().uuidString, url: "", date: "2020.01.03"),
                .init(id: UUID().uuidString, url: "", date: "2020.01.03")
            ])
        ]
        dummyAlbums.sort { (l, r) -> Bool in
            return l.date < r.date
        }
        albumsRelay.accept(dummyAlbums)
    }
    
    func add(album: Album) {
        var albums = albumsRelay.value
        albums.insert(album, at: 0)
        albumsRelay.accept(albums)
    }
}
