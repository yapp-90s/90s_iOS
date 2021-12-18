//
//  FilmType.swift
//  90s
//
//  Created by 성다연 on 2021/11/27.
//

import Foundation

struct FilmType : Codable {
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
//    var color : Int {
//        switch code {
//        case 1001 : return 0x727379
//        case 1002 : return 0x53555A
//        case 1003 : return 0x8276AF
//        case 1004 : return 0x517796
//        default   : return 0xFFFFFF
//        }
//    }
    /// 필름 생성의 필름 introView 바탕 색
    var filmTypeInfoBackgroundColor : Int {
        switch code {
        case 1001 : return 0x606064
        case 1002 : return 0x35363B
        case 1003 : return 0x665C8F
        case 1004 : return 0x3F5B73
        default   : return 0
        }
    }
    
    /// 필름 생성의 필름 introView - labelView 바탕 색
    var filmTypeInfoLabelBackgroundColor : Int {
        switch code {
        case 1001 : return 0x727379
        case 1002 : return 0x4A4B51
        case 1003 : return 0x8276AF
        case 1004 : return 0x517796
        default   : return 0
        }
    }

    /// 필름 별 이미지 가로 크기
    var imageWidth : Int {
        switch code {
        case 1001 : return 60
        case 1002 : return 80
        case 1003 : return 60
        case 1004 : return 80
        default   : return 0
        }
    }
    
    /// 필름 목록에서 보여줄 수 있는 필름 속 이미지 개수
    var maxCountImageView : Int {
        switch code {
        case 1001, 1003 : return 3
        case 1002, 1004 : return 2
        default         : return 0
        }
    }
}
