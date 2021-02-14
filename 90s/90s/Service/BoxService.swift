//
//  BoxService.swift
//  90s
//
//  Created by 김진우 on 2021/01/23.
//

import Foundation

final class BoxService {
    
    static let shared = BoxService()
    
    private let box: Box
    
    var photos: [Photo] {
        box.photos
    }
    
    private init() {
        self.box = BoxService.fetchBox()
    }
    
    init(box: Box) {
        self.box = box
    }
    
    private static func fetchBox() -> Box {
        return Box(photos: [])
    }
}
