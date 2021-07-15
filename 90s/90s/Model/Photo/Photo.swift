//
//  Photo.swift
//  90s
//
//  Created by 김진우 on 2020/12/27.
//

import UIKit


// 필름에 추가된 후
struct Photo {
    let photoUid : Int
    var filmUid : Int = -1
    let url: String
    let date: String
    
    func isEqual(id: Int) -> Bool {
        return self == id
    }
}

extension Photo: Equatable {
    static func ==(lhs: Photo, rhs: Photo) -> Bool {
        return lhs.photoUid == rhs.photoUid
    }
    
    static func ==(lhs: Photo, rhs: Int) -> Bool {
        return lhs.photoUid == rhs
    }
    
    var image: UIImage {
        return UIImage(named: "photo\(Int.random(in: 0...8)).png")!
    }
}

