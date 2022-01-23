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
    private let client: AlbumClient = .shared
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
    let allAlbums: Observable<[Album]>
    let completeAlbums: Observable<[Album]>
    let makeingAlbums: Observable<[Album]>
    
    private init() {
        allAlbums = albumsRelay
            .asObservable()
            .subscribe(on: SerialDispatchQueueScheduler(queue: queue, internalSerialQueueName: UUID().uuidString))
        
        completeAlbums = allAlbums
            .map { $0.filter { $0.completedAt != nil } }
        
        makeingAlbums = allAlbums
            .map { $0.filter { $0.completedAt == nil } }
        
        bindAction()
    }
    
    private func bindAction() {
        requestAll
            .flatMap(client.allAlbum(_:))
            .bind(to: albumsRelay)
            .disposed(by: disposeBag)
        
        create
            .flatMap(client.create(_:))
            .filter { $0 != nil }
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
    
    func update(id: Int, album: Album) -> Bool {
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
    
    func delete(id: Int) -> Bool {
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
    
    
    func updatePhoto(at albumUID: Int, page: Int, index: Int, photoUID: Int) {
        
    }
}
