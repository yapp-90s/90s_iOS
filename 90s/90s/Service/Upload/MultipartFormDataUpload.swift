//
//  MultipartFormDataUpload.swift
//  90s
//
//  Created by woongs on 2022/01/01.
//

import Foundation
import Moya

protocol MultipartFormDataUploadble {
    var data: Data { get }
    var name: String { get }
    var fileName: String? { get }
    var mimeType: String? { get }
}

extension MultipartFormDataUploadble {
    
    var multipartFormData: MultipartFormData {
        return MultipartFormData(
            provider: .data(self.data),
            name: self.name,
            fileName: self.fileName,
            mimeType: self.mimeType
        )
    }
}

struct UploadableImage: MultipartFormDataUploadble {
    
    var data: Data
    var name: String
    var fileName: String?
    var mimeType: String?
    
    init(
        data: Data,
        name: String = "image",
        fileName: String? = "img_\(Date().timeIntervalSince1970).jpeg",
        mimeType: String? = "image/jpeg"
    ) {
        self.data = data
        self.name = name
        self.fileName = fileName
        self.mimeType = mimeType
    }
}
