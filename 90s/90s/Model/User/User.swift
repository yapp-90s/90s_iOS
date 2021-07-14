//
//  User.swift
//  90s
//
//  Created by 성다연 on 2021/07/14.
//

import Foundation


struct User {
    let uid : Int
    var name : String
    var password : String?
    
    var emailKakao : String
    var emailGoogle : String
    var phoneNum : String
    
    var created_at : String
    var updated_at : String
    
    var roles : [Roles]
    var enabled : Bool
//    var authorities : [Roles]
//    var username : String
    let jwt : String
    
    var accountNonExpired : Bool
    var accountNonLocked : Bool
    var credentialNonExpired : Bool
}

enum Roles : String {
    case ROLE_TESTER = "ROLE_TESTER"
}
