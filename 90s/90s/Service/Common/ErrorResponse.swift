//
//  ErrorResponse.swift
//  90s
//
//  Created by woongs on 2021/11/20.
//

import Foundation

struct ErrorResponse: Decodable {
    var message: String
    var status: Int
}
