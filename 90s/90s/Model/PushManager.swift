//
//  PushManager.swift
//  90s
//
//  Created by woongs on 2021/12/19.
//

import Foundation

public class PushManager {
    
    public let shared: PushManager = PushManager()
    private init() { }
    
    private struct Key {
        static let isReceivingEvent = "isReceivingEvent"
    }
    
    var isReceivingEvent: Bool {
        return UserDefaults.standard.bool(forKey: Key.isReceivingEvent)
    }
    
    func toggleReceivingEvent() {
        let receivingEvent = UserDefaults.standard.bool(forKey: Key.isReceivingEvent)
        UserDefaults.standard.set(!receivingEvent, forKey: Key.isReceivingEvent)
    }
}
