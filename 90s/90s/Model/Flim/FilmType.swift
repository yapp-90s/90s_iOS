//
//  FilmType.swift
//  90s
//
//  Created by 성다연 on 2021/11/27.
//

import Foundation

struct FilmType : Codable {
    enum FilmTypeItem {
        case None
        case Mono
        case MossPink
        case ForgetMeNot
    }
    
    var uid : Int
    var code : Int
    var max : Int
    
    var type : FilmTypeItem {
        switch code {
        case 1001 : return .None
        case 1002 : return .Mono
        case 1003 : return .MossPink
        case 1004 : return .ForgetMeNot
        }
    }

    var printDaysCount : Int {
        return 12
    }
    
    var photoCount : Int {
        return 36
    }
    
    var image : String {
        switch type {
        case .None : return "filmroll_none"
        case .Mono : return "filmroll_mono"
        case .MossPink : return "filmroll_mosspink"
        case .ForgetMeNot : return "filmroll_forgetmenot"
        }
    }

    /// 필름 생성의 필름 introView 바탕 색
    var filmTypeInfoBackgroundColor : Int {
        switch type {
        case .None : return 0x606064
        case .Mono : return 0x35363B
        case .MossPink : return 0x665C8F
        case .ForgetMeNot : return 0x3F5B73
        }
    }
    
    /// 필름 생성의 필름 introView - labelView 바탕 색
    var filmTypeInfoLabelBackgroundColor : Int {
        switch type {
        case .None : return 0x727379
        case .Mono : return 0x4A4B51
        case .MossPink : return 0x8276AF
        case .ForgetMeNot : return 0x517796
        }
    }

    /// 필름 별 이미지 가로 크기
    var imageWidth : Int {
        switch type {
        case .None : return 60
        case .Mono : return 80
        case .MossPink : return 60
        case .ForgetMeNot : return 80
        }
    }
    
    /// 필름 목록에서 보여줄 수 있는 필름 속 이미지 개수
    var maxCountImageView : Int {
        switch type {
        case .None, .MossPink : return 3
        case .Mono, .ForgetMeNot : return 2
        }
    }
}
