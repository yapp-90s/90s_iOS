//
//  AlbumService.swift
//  90s
//
//  Created by 김진우 on 2021/01/23.
//

import Foundation

final class AlbumService {
    
    static let shared = AlbumService()
    
    var cover: AlbumCover?
    var name: String?
    var template: Template?
    
    private init() {}
    
    func createAlbum() -> Album? {
        
        return nil
    }
}
