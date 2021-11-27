//
//  LoginOAuth.swift
//  90s
//
//  Created by woongs on 2021/10/09.
//

import Foundation

struct LoginOAuthToken {
    
    var oAuthToken: String
    var email: String
    
    init(_ oAuthToken: String, _ email: String) {
        self.oAuthToken = oAuthToken
        self.email = email
    }
}
