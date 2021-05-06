//
//  AlbumCreateCellViewModel.swift
//  90s
//
//  Created by 김진우 on 2021/04/10.
//

import Foundation
import RxRelay
import RxSwift

final class AlbumCreateCellViewModel {
    
    let disposeBag = DisposeBag()
    
    // MARK: - Input
    let createAlbum: PublishRelay<Void> = .init()
    
    // MARK: - Output
    var openCreateAlbum: Observable<Void>
    
    init() {
        openCreateAlbum = createAlbum
            .asObservable()
        
        setAction()
    }
    
    private func setAction() {
    }
}
