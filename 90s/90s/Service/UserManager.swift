//
//  UserManager.swift
//  90s
//
//  Created by woongs on 2021/11/13.
//

import Foundation

class UserManager {
    static let shared = UserManager()
    private init() { }
    
    private struct Keys {
        static let oAuthToken = "oAuthToken"
    }
    
    func getOAuthToken() -> String? {
        UserDefaults.standard.string(forKey: Keys.oAuthToken)
    }
    
    func saveOAuthToken(_ token: String) {
        UserDefaults.standard.set(token, forKey: Keys.oAuthToken)
    }
}
