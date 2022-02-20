//
//  ResultResponse.swift
//  90s
//
//  Created by 김진우 on 2022/01/31.
//

struct ResultResponse: Codable {
    let result: Bool
    let message: String?
    
    enum CodingKeys: String, CodingKey {
        case result
        case message = "msg"
    }
}
