//
//  ImageService.swift
//  90s
//
//  Created by woong on 2021/06/12.
//

import Foundation
import RxSwift
import UIKit.UIImage

protocol ImageServiceProtocol {
    func saveImage(_ data: Data)
    var saveCompletion: PublishSubject<ImageServiceResponse> { get }
}

enum ImageServiceResponse {
    case success
    case invalidData
    case savingError(Error)
}

class ImageService: NSObject, ImageServiceProtocol {
    
    var saveCompletion = PublishSubject<ImageServiceResponse>()
    
    func saveImage(_ data: Data) {
        guard let image = UIImage(data: data) else {
            saveCompletion.onNext(.invalidData)
            return
        }
        UIImageWriteToSavedPhotosAlbum(image, self, #selector(completedSave), nil)
    }
    
    @objc private func completedSave(_ image: UIImage, didFinishSavingWithError error: Error?, contextInfo: UnsafeRawPointer) {
        if let error = error {
            saveCompletion.onNext(.savingError(error))
            return
        }
        saveCompletion.onNext(.success)
    }
}
