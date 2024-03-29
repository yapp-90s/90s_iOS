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
    let filmUid : Int?
    
    init(photoUid : Int, paperNum : Int, sequence: Int, url : String, filmUid: Int?) {
        self.photoUid = photoUid
        self.paperNum = paperNum
        self.sequence = sequence
        self.url = url
        self.filmUid = filmUid
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
            let page = Page(number: number, imagesURL: sortedPhotos[number].map { $0?.url == nil ? nil : .init(string: $0!.url) })
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

    var height: CGFloat {
        return 100
    }
}

