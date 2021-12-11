//
//  AlbumClient.swift
//  90s
//
//  Created by 김진우 on 2021/11/28.
//

import Foundation

import RxSwift
import RxAlamofire

final class AlbumClientStub {
    
    static let shared = AlbumClientStub()
    
    private var albums: [Album] = [
//        .init(uid: 0, coverUid: 0, createdAt: "2021-08-01T00:10:38", endAt: "2021-08-01T00:10:38", isComplete: false, layoutUid: 0, name: "Dummy Not Complete", readCount: 0, updatedAt: "2021-08-01T00:10:38"),
//        .init(uid: 0, coverUid: 0, createdAt: "2021-08-01T00:10:38", endAt: "2021-08-01T00:10:38", isComplete: true, layoutUid: 1, name: "Dummy Complete", readCount: 0, updatedAt: "2021-08-01T00:10:38")
//        .init(uid: 0, name: "Dummy Complete", createdAt: "2021-08-01T00:10:38", updatedAt: "2021-08-01T00:10:38", completedAt: "2021-08-01T00:10:38", totalPaper: 9, cover: .candy),
//        .init(uid: "1", name: "Dummy Making", createdAt: "2021-08-01T00:10:38", updatedAt: "2021-08-01T00:10:38", totalPaper: 9, cover: .stickyBubble)
    ]
    
    private let queue = DispatchQueue(label: "AlbumClientStub", qos: .utility)
    private let decoder = JSONDecoder()
    private let disposeBag = DisposeBag()
    
    private init() {
    }
    
    func allAlbum(_ void: Void) -> Observable<[Album]> {
        queue.sync {
            return Observable.just(albums)
        }
    }
    
    func all(_ void: Void) -> [Album] {
        queue.sync {
            return albums
        }
    }
    
    func create(_ albumCreate: AlbumCreate) -> Bool {
        queue.sync {
//            albums.insert(.init(uid: UUID().uuidString, name: albumCreate.name.value, createdAt: Date().dateToString(), updatedAt: Date().dateToString(), totalPaper: 8, cover: albumCreate.cover.value), at: 0)
            return true
        }
    }
    
    func addPhoto(_ photo: Photo) -> Bool {
        queue.sync {
            return true
        }
    }
    
    func complte(_ id: String) -> Bool {
        queue.sync {
            return true
        }
    }
    
    func delete(_ id: String) -> Bool {
        queue.sync {
            return true
        }
    }
}

final class AlbumClient {
    
    static let shared = AlbumClient()
    
    private let decoder = JSONDecoder()
    private let disposeBag = DisposeBag()
    
    private init() {
    }
    
    func allAlbum(_ void: Void) -> Observable<[Album]> {
        return RxAlamofire.request(AlbumRouter.all)
            .data()
            .decode(type: [AlbumResponse].self, decoder: decoder)
            .map { $0.compactMap { $0.album } }
    }
    
    func all(_ void: Void) -> [Album] {
        return [
//            .init(uid: 0, coverUid: 0, createdAt: "2021-08-01T00:10:38", endAt: "2021-08-01T00:10:38", isComplete: false, layoutUid: 0, name: "Dummy Not Complete", readCount: 0, updatedAt: "2021-08-01T00:10:38")
        ]
    }
    
    func create(_ albumCreate: AlbumCreate) -> Bool {
        return true
    }
    
    func addPhoto(_ photo: Photo) -> Bool {
        return true
    }
    
    func complte(_ id: String) -> Bool {
        return true
    }
    
    func delete(_ id: String) -> Bool {
        return true
    }
    
//    func plant(danji: DanjiCreate) -> Observable<Danji> {
//        return RxAlamofire.request(DanjiRouter.plant(danji: danji))
//            .validate(statusCode: 200..<300)
//            .data()
//            .decode(type: NetworkResult<Danji>.self, decoder: decoder)
//            .map { $0.data }
//    }
//
//    func sort(ids: [String]) -> Observable<[Danji]> {
//        return RxAlamofire.request(DanjiRouter.sort(ids: ids))
//            .data()
//            .decode(type: NetworkResult<[Danji]>.self, decoder: decoder)
//            .map { $0.data }
//    }
//
//    func mood(id: String, mood: Danji.Mood) -> Observable<Danji> {
//        return RxAlamofire.request(DanjiRouter.mood(id: id, mood: mood))
//            .data()
//            .decode(type: Danji.self, decoder: decoder)
//    }
//
//    func delete(danjiID: String) -> Observable<Int> {
//        return RxAlamofire.request(DanjiRouter.delete(id: danjiID))
//            .validate(statusCode: 200..<300)
//            .data()
//            .decode(type: Int.self, decoder: decoder)
//    }
}
