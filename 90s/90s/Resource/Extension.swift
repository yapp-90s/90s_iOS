//
//  Extension.swift
//  90s
//
//  Created by 성다연 on 2021/02/20.
//

import Foundation


extension Date {
    func dateToString() -> String {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy.MM.dd"
        return dateFormatter.string(from: Date())
    }
}
