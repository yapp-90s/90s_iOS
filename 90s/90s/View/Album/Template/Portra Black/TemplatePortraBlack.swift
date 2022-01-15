//
//  TemplatePortraBlack.swift
//  Template
//
//  Created by 김진우 on 2021/08/21.
//

import UIKit

import SnapKit

final class TemplatePortraBlack: UIView, TemplateView {
    
    let scale = UIScreen.main.bounds.width / 323
    
    var currentIndex: Int = -1
//    enum Kind {
//        case portraBlack
//        case portraWhite
//        case moodyPaper
//        case grass
//        case polaroid
//        case gradient
//    }: TemplateImageViewDelegate?
    
    lazy var imageView1: PortraBlackTemplateImageView = {
        let imageView = PortraBlackTemplateImageView()
        imageView.tag = 0
        imageView.delegate = self
        imageView.backgroundColor = .gray
        addSubview(imageView)
        return imageView
    }()
    
    lazy var imageView2: PortraBlackTemplateImageView = {
        let imageView = PortraBlackTemplateImageView()
        imageView.tag = 1
        imageView.delegate = self
        imageView.backgroundColor = .gray
        addSubview(imageView)
        return imageView
    }()
    
    lazy var imageView3: PortraBlackTemplateImageView = {
        let imageView = PortraBlackTemplateImageView()
        imageView.tag = 2
        imageView.delegate = self
        imageView.backgroundColor = .gray
        addSubview(imageView)
        return imageView
    }()
    
    init() {
        super.init(frame: .zero)
        
        setLayout()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setLayout() {
        backgroundColor = .black
        imageView1.snp.makeConstraints {
            $0.width.height.equalTo(144 * scale)
            $0.top.equalToSuperview().offset(30 * scale)
            $0.left.equalToSuperview().offset(46 * scale)
        }
        
        imageView2.snp.makeConstraints {
            $0.width.height.equalTo(144 * scale)
            $0.top.equalTo(imageView1.snp.bottom).offset(23 * scale)
            $0.left.equalToSuperview().offset(133 * scale)
        }
    
        imageView3.snp.makeConstraints {
            $0.width.height.equalTo(144 * scale)
            $0.top.equalTo(imageView2.snp.bottom).offset(22 * scale)
            $0.left.equalToSuperview().offset(46 * scale)
        }
    }
}

extension TemplatePortraBlack: TemplateImageViewDelegate {
    func tapped(_ index: Int) {
        currentIndex = index
        let imagePicker = UIImagePickerController()
        imagePicker.sourceType = .photoLibrary
        imagePicker.allowsEditing = true
        imagePicker.delegate = self
        DispatchQueue.main.async {
            UIApplication.shared.keyWindow?.rootViewController?.present(imagePicker, animated: true, completion: nil)
        }
    }
}

extension TemplatePortraBlack: UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        var image: UIImage? = nil
        
        if let possibleImage = info[UIImagePickerController.InfoKey.editedImage] as? UIImage {
            image = possibleImage
        } else if let possibleImage = info[UIImagePickerController.InfoKey.originalImage] as? UIImage {
            image = possibleImage
        }
        
        if currentIndex == 0 {
            imageView1.image = image
        } else if currentIndex == 1 {
            imageView2.image = image
        } else {
            imageView3.image = image
        }
        
//        addImageButton.snp.removeConstraints()
//        addImageButton.snp.remakeConstraints {
//            $0.width.height.equalTo(80 * AppService.shared.layoutScale)
//            $0.top.equalTo(titleLabel.snp.bottom).offset(16 * AppService.shared.layoutScale)
//            $0.left.equalToSuperview().offset(32 * AppService.shared.layoutScale)
//        }
//        addImageButton.setImage(image, for: .normal)
//        if let image = image {
//            imageView.image = image
//        }
        DispatchQueue.main.async {
            picker.dismiss(animated: true, completion: nil)
        }
    }
}
