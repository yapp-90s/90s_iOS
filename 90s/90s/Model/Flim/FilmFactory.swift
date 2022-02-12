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
            Film(filmUid: 0, name: "필름 만들기", filmCode: 0, photos: [
                            Photo(photoUid: 0, paperNum: 0, sequence: 0, url: "test_pic1", filmUid: 0),
                            Photo(photoUid: 1, paperNum: 0, sequence: 0, url: "test_pic4", filmUid: 0),
                            Photo(photoUid: 2, paperNum: 0, sequence: 0, url: "test_pic2", filmUid: 0),
                            Photo(photoUid: 3, paperNum: 0, sequence: 0, url: "test_pic3", filmUid: 0),
                        ]),
            Film(filmUid: 1, name: "귀여운 필름", filmCode: 1002, photos: [
                            Photo(photoUid: 4, paperNum: 0, sequence: 0, url: "test_pic3", filmUid: 1),
                            Photo(photoUid: 5, paperNum: 0, sequence: 0, url: "test_pic1", filmUid: 1),
                            Photo(photoUid: 6, paperNum: 0, sequence: 0, url: "test_pic1", filmUid: 1),
                        ]),
            Film(filmUid: 2, name: "멋있는 필름", filmCode: 1001, photos: [
                           Photo(photoUid: 7, paperNum: 0, sequence: 0, url: "test_pic2", filmUid: 2),
                           Photo(photoUid: 8, paperNum: 0, sequence: 0, url: "test_pic3", filmUid: 2),
                           Photo(photoUid: 9, paperNum: 0, sequence: 0, url: "test_pic1"
                                 , filmUid: 2),
                           Photo(photoUid: 10, paperNum: 0, sequence: 0, url: "test_pic2", filmUid: 2),
                           Photo(photoUid: 11, paperNum: 0, sequence: 0, url: "test_pic4", filmUid: 2),
                       ]),
            Film(filmUid: 3, name: "차가운 필름", filmCode: 1003, photos: [
                            Photo(photoUid: 12, paperNum: 0, sequence: 0, url: "test_pic1", filmUid: 3),
                            Photo(photoUid: 13, paperNum: 0, sequence: 0, url: "test_pic4", filmUid: 3)
                        ]),
            Film(filmUid: 4, name: "차분한 필름", filmCode: 1004, photos: [
                            Photo(photoUid: 14, paperNum: 0, sequence: 0, url: "test_pic3", filmUid: 4),
                            Photo(photoUid: 15, paperNum: 0, sequence: 0, url: "test_pic4", filmUid: 4),
                            Photo(photoUid: 16, paperNum: 0, sequence: 0, url: "test_pic1", filmUid: 4),
                        ]),
            Film(filmUid: 5, name: "강렬한 필름", filmCode: 1002, photos: [
                           Photo(photoUid: 17, paperNum: 0, sequence: 0, url: "test_pic1", filmUid: 5),
                           Photo(photoUid: 18, paperNum: 0, sequence: 0, url: "test_pic4", filmUid: 5),
                           Photo(photoUid: 19, paperNum: 0, sequence: 0, url: "test_pic3", filmUid: 5),
                           Photo(photoUid: 20, paperNum: 0, sequence: 0, url: "test_pic3", filmUid: 5),
                           Photo(photoUid: 21, paperNum: 0, sequence: 0, url: "test_pic2", filmUid: 5),
                           Photo(photoUid: 22, paperNum: 0, sequence: 0, url: "test_pic2", filmUid: 5),
                       ]),
            Film(filmUid: 6, name: "귀여운 필름", filmCode: 1004, photos: [])
        ]
    }
    
    func createFilmCategoryList() -> [Film] {
        return [
            Film(filmUid: -1, name: "Mono", filmCode: 1002, photos: [
                            Photo(photoUid: -1, paperNum: 0, sequence: 0, url: "test_pic1", filmUid: -1),
                            Photo(photoUid: -1, paperNum: 0, sequence: 0, url: "test_pic1", filmUid: -1),
                            Photo(photoUid: -1, paperNum: 0, sequence: 0, url: "test_pic1", filmUid: -1)
                        ]),
            Film(filmUid: -2, name: "None", filmCode: 1001, photos: [
                            Photo(photoUid: -2, paperNum: 0, sequence: 0,  url: "test_pic2", filmUid: -2),
                            Photo(photoUid: -2, paperNum: 0, sequence: 0,  url: "test_pic2", filmUid: -2),
                            Photo(photoUid: -2, paperNum: 0, sequence: 0,  url: "test_pic2", filmUid: -2),
                        ]),
            Film(filmUid: -3, name: "Moss Pink", filmCode: 1003, photos: [
                            Photo(photoUid: -3, paperNum: 0, sequence: 0,  url: "test_pic3", filmUid: -3),
                            Photo(photoUid: -3, paperNum: 0, sequence: 0,  url: "test_pic3", filmUid: -3),
                        ]),
            Film(filmUid: -4, name: "Forget Me Not", filmCode: 1004, photos: [
                            Photo(photoUid: -4, paperNum: 0, sequence: 0,  url: "test_pic4", filmUid: -4),
                            Photo(photoUid: -4, paperNum: 0, sequence: 0,  url: "test_pic4", filmUid: -4),
                            Photo(photoUid: -4, paperNum: 0, sequence: 0,  url: "test_pic4", filmUid: -4),
                        ])
        ]
    }
}
