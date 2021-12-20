//
//  PushManager.swift
//  90s
//
//  Created by woongs on 2021/12/19.
//

import Foundation

public class PushManager {
    
    public static let shared: PushManager = PushManager()
    private init() { }
    
    private struct Key {
        static let isReceivingEvent = "isReceivingEvent"
    }
    
    var isReceivingEvent: Bool {
        return UserDefaults.standard.bool(forKey: Key.isReceivingEvent)
    }
    
    func updateReceivingEvent(isOn: Bool) {
        UserDefaults.standard.set(isOn, forKey: Key.isReceivingEvent)
    }
}
