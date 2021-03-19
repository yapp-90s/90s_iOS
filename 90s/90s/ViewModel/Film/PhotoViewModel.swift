//
//  PhotoViewModel.swift
//  90s
//
//  Created by 성다연 on 2021/02/15.
//

import Foundation
import RxSwift
import RxCocoa

class PhotoViewModel {
    var array : [TestPhoto] = []
    var photoObservable = BehaviorRelay<[TestPhoto]>(value: [])
    
    init() {
        setDefaultData()
        setObservableDefaultData()
    }
    
    func setDefaultData(){
        self.array = [TestPhoto(image: "test_pic1"),
                      TestPhoto(image: "test_pic2"),
                      TestPhoto(image: "test_pic3"),
                      TestPhoto(image: "test_pic4"),
                      TestPhoto(image: "test_pic2"),
                      TestPhoto(image: "test_pic2"),
                      TestPhoto(image: "test_pic3"),
                      TestPhoto(image: "test_pic4")]
    }
    
    func setObservableDefaultData(){
        let photos : [TestPhoto] = [TestPhoto(image: "test_pic1"),
                                    TestPhoto(image: "test_pic2"),
                                    TestPhoto(image: "test_pic3"),
                                    TestPhoto(image: "test_pic4"),
                                    TestPhoto(image: "test_pic2"),
                                    TestPhoto(image: "test_pic2"),
                                    TestPhoto(image: "test_pic3"),
                                    TestPhoto(image: "test_pic4")]
        
        photoObservable.accept(photos)
    }
}


