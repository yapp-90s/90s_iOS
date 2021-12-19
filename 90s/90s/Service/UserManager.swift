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
    
    private let serviceIdentifier = "com.team-90s"
    
    public func saveToken(_ token: String) {
        try? KeychainItem(service: self.serviceIdentifier, account: "token").saveItem(token)
    }
    
    public func deleteToken() {
        try? KeychainItem(service: self.serviceIdentifier, account: "token").deleteItem()
    }
    
    public func saveUserEmail(_ email: String) {
        try? KeychainItem(service: self.serviceIdentifier, account: "email").saveItem(email)
    }

    public var userEmail: String? {
        return try? KeychainItem(service: self.serviceIdentifier, account: "email").readItem()
    }
    
    public var token: String {
        do {
            return try KeychainItem(service: self.serviceIdentifier, account: "token").readItem()
        } catch {
            #if DEBUG
            print("❌ Not Found User Token, \(error)")
            #endif
            return ""
        }
    }

    public var appleIdentifier: String {
        get { (try? KeychainItem(service: self.serviceIdentifier, account: "identifier").readItem()) ?? "" }
        set {
            do {
                try KeychainItem(service: self.serviceIdentifier, account: "identifier").saveItem(newValue)
            } catch let error {
                #if DEBUG
                print("❌ Set saveItem \(newValue), \(error)")
                #endif
            }
        }
    }
    
    public var appleEmail: String? {
        get { try? KeychainItem(service: self.serviceIdentifier, account: "appleEmail").readItem() }
        set {
            if let email = newValue {
                try? KeychainItem(service: self.serviceIdentifier, account: "appleEmail").saveItem(email)
            }
        }
    }
}
