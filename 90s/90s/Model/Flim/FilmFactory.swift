//
//  FilmFactory.swift
//  90s
//
//  Created by 성다연 on 2021/05/15.
//

import Foundation

struct FilmFactory {
    func createDefaultUserData() -> [Film] {
        return [
            Film(uid: 0, name: "필름 만들기", filmType: .init(uid: 0, code: 0, max: -1), photos: [
                Photo(photoUid: 0, filmUid: 0, url: "test_pic1"),
                Photo(photoUid: 1, filmUid: 0, url: "test_pic4"),
                Photo(photoUid: 2, filmUid: 0, url: "test_pic2"),
                Photo(photoUid: 3, filmUid: 0, url: "test_pic3"),
            ]),
            Film(uid: 1, name: "귀여운 필름", filmType: .init(uid: 0, code: 1002, max: 10), photos: [
                Photo(photoUid: 4, filmUid: 1, url: "test_pic3"),
                Photo(photoUid: 5, filmUid: 1, url: "test_pic1"),
                Photo(photoUid: 6, filmUid: 1, url: "test_pic1"),
            ]),
            Film(uid: 2, name: "멋있는 필름", filmType: .init(uid: 0, code: 1001, max: 36), photos: [
                Photo(photoUid: 7, filmUid: 2, url: "test_pic2"),
                Photo(photoUid: 8, filmUid: 2, url: "test_pic3"),
                Photo(photoUid: 9, filmUid: 2, url: "test_pic1"),
                Photo(photoUid: 10, filmUid: 2, url: "test_pic2"),
                Photo(photoUid: 11, filmUid: 2, url: "test_pic4"),
            ]),
            Film(uid: 3, name: "차가운 필름", filmType: .init(uid: 0, code: 1003, max: 14), photos: [
                Photo(photoUid: 12, filmUid: 3, url: "test_pic1"),
                Photo(photoUid: 13, filmUid: 3, url: "test_pic4")
            ]),
            Film(uid: 4, name: "차분한 필름", filmType: .init(uid: 0, code: 1004, max: 3), photos: [
                Photo(photoUid: 14, filmUid: 3, url: "test_pic3"),
                Photo(photoUid: 15, filmUid: 3, url: "test_pic4"),
                Photo(photoUid: 16, filmUid: 3, url: "test_pic1"),
            ]),
            Film(uid: 5, name: "강렬한 필름", filmType: .init(uid: 0, code: 1002, max: 36), photos: [
                Photo(photoUid: 17, filmUid: 5, url: "test_pic1"),
                Photo(photoUid: 18, filmUid: 5, url: "test_pic4"),
                Photo(photoUid: 19, filmUid: 5, url: "test_pic3"),
                Photo(photoUid: 20, filmUid: 5, url: "test_pic3"),
                Photo(photoUid: 21, filmUid: 5, url: "test_pic2"),
                Photo(photoUid: 22, filmUid: 5, url: "test_pic2"),
            ]),
            Film(uid: 6, name: "귀여운 필름", filmType: .init(uid: 0, code: 1004, max: 10), photos: [])
        ]
    }
    
    func createFilmCategoryList() -> [Film] {
        return [
            Film(uid: -1, name: "Mono", filmType: .init(uid: 0, code: 1002, max: 10), photos: [
                Photo(photoUid: -1, filmUid: -1, url: "test_pic1"),
                Photo(photoUid: -1, filmUid: -1, url: "test_pic1"),
                Photo(photoUid: -1, filmUid: -1, url: "test_pic1")
            ]),
            Film(uid: -2, name: "None", filmType: .init(uid: 0, code: 1001, max: 20), photos: [
                Photo(photoUid: -2, filmUid: -2,  url: "test_pic2"),
                Photo(photoUid: -2, filmUid: -2,  url: "test_pic2"),
                Photo(photoUid: -2, filmUid: -2,  url: "test_pic2"),
            ]),
            Film(uid: -3, name: "Moss Pink", filmType: .init(uid: 0, code: 1003, max: 15), photos: [
                Photo(photoUid: -3, filmUid: -3,  url: "test_pic3"),
                Photo(photoUid: -3, filmUid: -3,  url: "test_pic3"),
            ]),
            Film(uid: -4, name: "Forget Me Not", filmType: .init(uid: 0, code: 1004, max: 9), photos: [
                Photo(photoUid: -4, filmUid: -4,  url: "test_pic4"),
                Photo(photoUid: -4, filmUid: -4,  url: "test_pic4"),
                Photo(photoUid: -4, filmUid: -4,  url: "test_pic4"),
            ])
        ]
    }
}
