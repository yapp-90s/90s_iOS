//
//  FilmType.swift
//  90s
//
//  Created by 성다연 on 2021/11/27.
//

import Foundation

struct FilmType : Codable {
    // TODO: 숫자 대신 명칭으로 변환
    enum FilmTypeItem {
        case none
        case mono
        case mossPink
        case forgetMeNot
    }
    
    var uid : Int
    var code : Int
    var max : Int
    
    var printDaysCount : Int {
        return 12
    }
    
    var photoCount : Int {
        return 36
    }
    var name : String {
        switch code {
        case 1001 : return "None"
        case 1002 : return "Mono"
        case 1003 : return "Moss Pink"
        case 1004 : return "Forget Me Not"
        default   : return "Create"
        }
    }
    
    var image : String {
        switch code {
        case 1001 : return "filmroll_none"
        case 1002 : return "filmroll_mono"
        case 1003 : return "filmroll_mosspink"
        case 1004 : return "filmroll_forgetmenot"
        default   : return "film_default"
        }
    }
    var color : Int {
        switch code {
        case 1001 : return 0x727379
        case 1002 : return 0x53555A
        case 1003 : return 0x8276AF
        case 1004 : return 0x517796
        default   : return 0xFFFFFF
        }
    }
    
    var imageWidth : Int {
        switch code {
        case 1001 : return 60
        case 1002 : return 80
        case 1003 : return 60
        case 1004 : return 80
        default   : return 0
        }
    }
    
    var maxCountImageView : Int {
        switch code {
        case 1001, 1003 : return 4
        case 1002, 1004 : return 3
        default         : return 0
        }
    }
}
