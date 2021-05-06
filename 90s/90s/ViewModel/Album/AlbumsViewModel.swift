//
//  AlbumsViewModel.swift
//  90s
//
//  Created by 김진우 on 2021/04/08.
//

import Foundation

import RxSwift
import RxRelay

final class AlbumsViewModel {
    private(set) var createViewModel: AlbumCreateCellViewModel = .init()
    private(set) var albums: Observable<[AlbumViewModel]> = .just([])
    let albumSection: BehaviorRelay<[AlbumSectionModel]> = .init(value: [])
    
    init() {
        fetchMockData()
        
        albums = AlbumProvider.observable
            .map { $0.map { AlbumViewModel(album: $0) } }
        
        AlbumProvider.observable
            .subscribe(onNext: { items in
                print(items.map { $0.id })
            })
            .disposed(by: disposedBag)
        
        albums
            .map { items in
                return [
                    AlbumSectionModel.sectionCreate(item: .statusCreate(viewMode: self.createViewModel)),
                    .sectionBanner,
                    .sectionHeader(items: [.statusHeader(title: "")]),
                    .sectionCover(items: items.map { AlbumSectionItem.statusCover(albums: $0) }),
                    .sectionHeader(items: [.statusHeader(title: "")]),
                    .sectionPreview(items: items.map { AlbumSectionItem.statusPreview(albums: $0) })
                ]
            }
            .bind(to: albumSection)
            .disposed(by: disposedBag)
    }
    
    let disposedBag = DisposeBag()

    private func fetchMockData() {
        let dummyAlbums: [Album] = [
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
        
        for album in dummyAlbums {
            AlbumProvider.addAndUpdate(album)
        }
    }
}
