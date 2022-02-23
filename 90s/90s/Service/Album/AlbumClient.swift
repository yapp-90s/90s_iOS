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
            .do(onNext: { data in
                print(String(data: data, encoding: .utf8) ?? "nil")
            })
            .decode(type: [AlbumResponse].self, decoder: decoder)
            .map { $0.compactMap { $0.album } }
    }
    
    func all(_ void: Void) -> [Album] {
        return [
//            .init(uid: 0, coverUid: 0, createdAt: "2021-08-01T00:10:38", endAt: "2021-08-01T00:10:38", isComplete: false, layoutUid: 0, name: "Dummy Not Complete", readCount: 0, updatedAt: "2021-08-01T00:10:38")
        ]
    }
    
    func create(_ albumCreate: AlbumCreate) -> Observable<Album?> {
        print(AlbumRouter.create(albumCreate: albumCreate).urlRequest?.curlString ?? "nil")
        return RxAlamofire.request(AlbumRouter.create(albumCreate: albumCreate))
            .data()
            .do(onNext: { data in
                print(String(data: data, encoding: .utf8) ?? "nil")
            })
            .decode(type: AlbumResponse.self, decoder: decoder)
            .map { $0.album }
    }
    
    func addPhoto(_ photo: Photo) -> Bool {
        return true
    }
    
    func complte(_ id: String) -> Observable<Bool> {
        return RxAlamofire.request(AlbumRouter.complete(id: id))
            .data()
            .decode(type: ResultResponse.self, decoder: decoder)
            .map { $0.result }
    }
    
    func delete(_ id: String) -> Observable<Bool> {
        return RxAlamofire.request(AlbumRouter.delete(id: id))
            .data()
            .decode(type: ResultResponse.self, decoder: decoder)
            .map { $0.result }
    }
    
    func deletes(_ ids: [String]) -> Observable<Bool> {
        let a = Observable.merge(ids.map { id in
            return RxAlamofire.request(AlbumRouter.delete(id: id))
                .data()
                .decode(type: ResultResponse.self, decoder: decoder)
                .map { $0.result }
        })
            .reduce(false) { a, b in
                return a || b
            }
        return a
    }
}
