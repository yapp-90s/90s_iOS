//
//  Album.swift
//  90s
//
//  Created by 김진우 on 2020/12/27.
//

import UIKit

struct Album {
    var user : [String]
    var albumIndex : Int!
    let albumName : String
    var albumStartDate : String?
    var albumEndDate : String?
    let albumLayout : AlbumLayout
    let albumMaxCount : Int
    var photos : [UIImage]
}
