//
//  Box.swift
//  90s
//
//  Created by 김진우 on 2021/01/23.
//

import Foundation

struct Box {
    private(set) var photos: [Photo]
}

extension Box {
    mutating func add(_ photos: [Photo]) {
        self.photos.append(contentsOf: photos)
    }
    
    mutating func add(_ film: Film) {
        add(film.photos)
    }
    
    @discardableResult
    mutating func remove(_ id: String) -> Photo? {
        guard let index = photos.firstIndex(where: { $0.id == id }) else { return nil }
        return photos.remove(at: index)
    }
    
    @discardableResult
    mutating func remove(_ photo: Photo) -> Photo? {
        
        guard let index = photos.firstIndex(of: photo) else { return nil }
        return photos.remove(at: index)
        
    }
}
