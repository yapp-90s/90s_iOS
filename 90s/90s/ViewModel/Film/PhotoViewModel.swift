//
//  PhotoViewModel.swift
//  90s
//
//  Created by 성다연 on 2021/02/15.
//

import Foundation

class PhotoViewModel {
    var array : [TestPhoto] = []
    
    init() {
        setDefaultData()
    }
    
    func setDefaultData(){
        self.array = [TestPhoto(image: "picture1"),
                      TestPhoto(image: "picture2"),
                      TestPhoto(image: "picture3"),
                      TestPhoto(image: "picture4"),
                      TestPhoto(image: "picture2"),
                      TestPhoto(image:  "picture1"),
                      TestPhoto(image: "picture4"),
                      TestPhoto(image: "picture3")]
    }
}


