//
//  AlbumProvider.swift
//  90s
//
//  Created by 김진우 on 2021/04/07.
//

import RxSwift
import RxRelay

struct AlbumProvider {
    // input
    private static let albumRelay = BehaviorRelay<[String: (album: Album, count: Int, updatedAt: Date)]>(value: [:])
    private static let albumObservable = albumRelay
        .asObservable()
        .subscribeOn(SerialDispatchQueueScheduler(queue: queue, internalSerialQueueName: UUID().uuidString))
    // output
    static let observable: Observable<[Album]> = albumObservable.map { $0.map { $0.value.album } }
    private static let queue = DispatchQueue(label: "RepoProvider.RxMVVMTexture.com", qos: .utility)
    
    static func addAndUpdate(_ album: Album) {
        queue.sync {
            var albumValue = self.albumRelay.value
            if let record = albumValue[album.id] {
                albumValue[album.id] = (album: album, count: record.count + 1, updatedAt: Date())
            } else {
                albumValue[album.id] = (album: album, count: 1, updatedAt: Date())
            }
            self.albumRelay.accept(albumValue)
        }
    }
    
    static func update(_ album: Album) {
        queue.async {
            var albumValue = self.albumRelay.value
            if let record = albumValue[album.id] {
                albumValue[album.id] = (album: album, count: record.count, updatedAt: Date())
            }
            self.albumRelay.accept(albumValue)
        }
    }
    
    static func retain(id: String) {
        queue.async {
            var albumValue = self.albumRelay.value
            var record = albumValue[id]
            guard record != nil else { return }
            
            record?.count += 1
            albumValue[id] = record
            self.albumRelay.accept(albumValue)
        }
    }
    
    static func release(id: String) {
//        queue.async {
//            var albumValue = self.albumRelay.value
//            var record = albumValue[id]
//            guard record != nil else { return }
//
//            record?.count -= 1
//            if record?.count ?? 0 < 1 {
//                record = nil
//            }
//            albumValue[id] = record
//            self.albumRelay.accept(albumValue)
//        }
    }
    
    static func album(id: String) -> Album? {
        var album: Album?
        queue.sync {
            album = self.albumRelay.value[id]?.album
        }
        return album
    }
    
    static func observable(id: String) -> Observable<Album?> {
        return albumObservable
            .map { $0[id] }
            .distinctUntilChanged { $0?.updatedAt == $1?.updatedAt }
            .map { $0?.album }
            .share(replay: 1, scope: .whileConnected)
    }
}
