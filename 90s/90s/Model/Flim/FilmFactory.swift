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
            Film(uid: 0, name: "필름 만들기", filmType: .init(uid: 0, code: 0, name: .Create, createdAt: Date().toString), photos: [
                Photo(photoUid: 0, url: "test_pic1", date: "\(Date())"),
                Photo(photoUid: 1, url: "test_pic1", date: "\(Date())"),
                Photo(photoUid: 2, url: "test_pic1", date: "\(Date())"),
                Photo(photoUid: 2, url: "test_pic1", date: "\(Date())"),
            ], maxCount: 36, state: .create),
            Film(uid: 2, name: "귀여운 필름", filmType: .init(uid: 1, code: 0, name: .ForgetMeNot, createdAt: Date().toString), photos: [
                Photo(photoUid: 3, url: "test_pic3", date: "\(Date())"),
                Photo(photoUid: 4, url: "test_pic3", date: "\(Date())"),
                Photo(photoUid: 5, url: "test_pic3", date: "\(Date())"),
            ], maxCount: 36, state: .adding),
            Film(uid: 2, name: "멋있는 필름", filmType: .init(uid: 3, code: 0, name: .Mono, createdAt: Date().toString), photos: [
                Photo(photoUid: 6, url: "test_pic2", date: "\(Date())"),
                Photo(photoUid: 7, url: "test_pic2", date: "\(Date())"),
                Photo(photoUid: 8, url: "test_pic2", date: "\(Date())"),
                Photo(photoUid: 8, url: "test_pic2", date: "\(Date())"),
                Photo(photoUid: 8, url: "test_pic2", date: "\(Date())"),
            ], maxCount: 3, state: .adding),
            Film(uid: 3, name: "차가운 필름", filmType: .init(uid: 1, code: 0, name: .MossPink, createdAt: Date().toString), photos: [
                Photo(photoUid: 9, url: "test_pic4", date: "\(Date())"),
                Photo(photoUid: 10, url: "test_pic4", date: "\(Date())")
            ], maxCount: 36, state: .printing),
            Film(uid: 4, name: "차분한 필름", filmType: .init(uid: 5, code: 0, name: .None, createdAt: Date().toString), photos: [
                Photo(photoUid: 12, url: "test_pic3", date: "\(Date())"),
                Photo(photoUid: 13, url: "test_pic3", date: "\(Date())"),
                Photo(photoUid: 14, url: "test_pic3", date: "\(Date())"),
            ], maxCount: 36, state: .printing),
            Film(uid: 5, name: "강렬한 필름", filmType: .init(uid: 4, code: 0, name: .Mono, createdAt: Date().toString), photos: [
                Photo(photoUid: 15, url: "test_pic1", date: "\(Date())"),
                Photo(photoUid: 16, url: "test_pic1", date: "\(Date())"),
                Photo(photoUid: 17, url: "test_pic1", date: "\(Date())"),
                Photo(photoUid: 15, url: "test_pic1", date: "\(Date())"),
                Photo(photoUid: 16, url: "test_pic1", date: "\(Date())"),
                Photo(photoUid: 17, url: "test_pic1", date: "\(Date())"),
            ], maxCount: 36, state: .complete),
            Film(uid: 6, name: "귀여운 필름", filmType: .init(uid: 2, code: 0, name: .ForgetMeNot, createdAt: Date().toString), photos: [], maxCount: 36, state: .adding)
        ]
    }
}
