//
//  Photo.swift
//  90s
//
//  Created by 김진우 on 2020/12/27.
//

import UIKit

struct Photo : Codable {
    let photoUid : Int
    let paperNum: Int
    let sequence: Int
    let url: String
    
//    let createdAt: String
//    let updatedAt: String
    
    init(photoUid : Int, paperNum : Int, sequence: Int, url : String) {
        self.photoUid = photoUid
        self.paperNum = paperNum
        self.sequence = sequence
        self.url = url
//        self.createdAt = "\(Date())"
//        self.updatedAt = "\(Date())"
    }
    
    static func convertToPages(from photos: [Photo], template: Template) -> [Page] {
        var sortedPhotos: [[Photo?]] = []
        var result: [Page] = []
        
        for index in 0..<template.page {
            sortedPhotos.append([])
            for _ in 0..<template.imageMaxCount {
                sortedPhotos[index].append(nil)
            }
        }
        
        for photo in photos {
            sortedPhotos[photo.paperNum][photo.sequence] = photo
        }
        
        for number in 0..<sortedPhotos.count {
            let page = Page(number: number, images: sortedPhotos[number].map { $0?.image })
            result.append(page)
        }
        
        return result
    }
}

extension Photo: Equatable {
    static func ==(lhs: Photo, rhs: Photo) -> Bool {
        return lhs.photoUid == rhs.photoUid
    }
    
    static func ==(lhs: Photo, rhs: Int) -> Bool {
        return lhs.photoUid == rhs
    }
    
    func isEqual(id: Int) -> Bool {
        return self == id
    }
    
    var image: UIImage {
        return UIImage(named: "test_pic\(Int.random(in: 1...4)).png")!
    }
    
    var height: CGFloat {
        return image.size.height
    }
}

