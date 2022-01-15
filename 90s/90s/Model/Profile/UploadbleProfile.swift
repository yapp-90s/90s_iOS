//
//  UploadbleProfile.swift
//  90s
//
//  Created by woongs on 2022/01/01.
//

import Foundation
import Moya

struct UploadbleProfile {
    var name: String
    var image: UploadableImage
    
    var multipartFormDatas: [MultipartFormData] {
        return [
            name.multipartFormData(name: "name"),
            self.image.multipartFormData
        ]
    }
}

private extension String {
    
    func multipartFormData(name: String) -> MultipartFormData {
        let data = self.data(using: .utf8) ?? Data()
        return .init(provider: .data(data), name: name)
    }
}
