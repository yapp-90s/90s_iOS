//
//  String+.swift
//  90s
//
//  Created by 김진우 on 2021/12/26.
//

import Foundation

extension String {
    static let serverDateFormatter: DateFormatter = {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd"
        return dateFormatter
    }()
    
    static let uiDateFormatter: DateFormatter = {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy.MM.dd"
        return dateFormatter
    }()
    
    var dateString: String {
        if let serverDateString = self.split(separator: "T").first,
           let date = String.serverDateFormatter.date(from: String(serverDateString)) {
            let uiDateString = String.uiDateFormatter.string(from: date)
            return uiDateString
        }
        return ""
    }
}
