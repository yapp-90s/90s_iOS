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
        get { try? KeychainItem(service: self.serviceIdentifier, account: "email").readItem() }
        set {
            if let email = newValue {
                try? KeychainItem(service: self.serviceIdentifier, account: "email").saveItem(email)
            }
        }
    }
}
