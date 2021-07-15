//
//  FilmFactory.swift
//  90s
//
//  Created by 성다연 on 2021/05/15.
//

import Foundation

struct FilmFactory {
    func createDefaultData() -> [Film] {
        return [
            Film(uid: 0, name: "필름 만들기", filmType: .init(name: .Create), photos: [
                Photo(photoUid: 0, url: "test_pic1", date: "\(Date())"),
                Photo(photoUid: 1, url: "test_pic1", date: "\(Date())"),
                Photo(photoUid: 2, url: "test_pic1", date: "\(Date())"),
                Photo(photoUid: 2, url: "test_pic1", date: "\(Date())"),
            ], maxCount: 36, state: .create),
            Film(uid: 1, name: "귀여운 필름", filmType: .init(name: .Cute), photos: [
                Photo(photoUid: 3, url: "test_pic3", date: "\(Date())"),
                Photo(photoUid: 4, url: "test_pic3", date: "\(Date())"),
                Photo(photoUid: 5, url: "test_pic3", date: "\(Date())"),
            ], maxCount: 36, state: .adding),
            Film(uid: 2, name: "멋있는 필름", filmType: .init(name: .Hot), photos: [
                Photo(photoUid: 6, url: "test_pic2", date: "\(Date())"),
                Photo(photoUid: 7, url: "test_pic2", date: "\(Date())"),
                Photo(photoUid: 8, url: "test_pic2", date: "\(Date())"),
                Photo(photoUid: 8, url: "test_pic2", date: "\(Date())"),
                Photo(photoUid: 8, url: "test_pic2", date: "\(Date())"),
            ], maxCount: 3, state: .adding),
            Film(uid: 3, name: "차가운 필름", filmType: .init(name: .Cold), photos: [
                Photo(photoUid: 9, url: "test_pic4", date: "\(Date())"),
                Photo(photoUid: 10, url: "test_pic4", date: "\(Date())")
            ], maxCount: 36, state: .printing),
            Film(uid: 4, name: "차분한 필름", filmType: .init(name: .Dandy), photos: [
                Photo(photoUid: 12, url: "test_pic3", date: "\(Date())"),
                Photo(photoUid: 13, url: "test_pic3", date: "\(Date())"),
                Photo(photoUid: 14, url: "test_pic3", date: "\(Date())"),
            ], maxCount: 36, state: .printing),
            Film(uid: 5, name: "생생한 필름", filmType: .init(name: .Nice), photos: [
                Photo(photoUid: 15, url: "test_pic1", date: "\(Date())"),
                Photo(photoUid: 16, url: "test_pic1", date: "\(Date())"),
                Photo(photoUid: 17, url: "test_pic1", date: "\(Date())"),
                Photo(photoUid: 15, url: "test_pic1", date: "\(Date())"),
                Photo(photoUid: 16, url: "test_pic1", date: "\(Date())"),
                Photo(photoUid: 17, url: "test_pic1", date: "\(Date())"),
            ], maxCount: 36, state: .complete),
            Film(uid: 6, name: "귀여운 필름", filmType: .init(name: .Cute), photos: [], maxCount: 36, state: .adding)
        ]
    }
}
