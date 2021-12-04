//
//  TemplateGradient.swift
//  Template
//
//  Created by 김진우 on 2021/10/16.
//

import Foundation

import SnapKit

final class TemplateGradient: UIView, TemplateView {
    
    let scale = UIScreen.main.bounds.width / 323
    
    var currentIndex: Int = -1
    
    lazy var backgroundImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.image = UIImage(named: "Template_Gradient_Background")
        addSubview(imageView)
        return imageView
    }()
    
    lazy var imageView1: GradientImageView = {
        let imageView = GradientImageView()
        imageView.tag = 0
        imageView.delegate = self
        imageView.backgroundColor = .gray
        addSubview(imageView)
        return imageView
    }()
    
    lazy var imageView2: GradientImageView = {
        let imageView = GradientImageView()
        imageView.tag = 1
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
        backgroundImageView.snp.makeConstraints {
            $0.top.left.bottom.right.equalToSuperview()
        }
        
        imageView2.transform = imageView2.transform.rotated(by: -6 / 180.0 * CGFloat.pi)
        imageView2.snp.makeConstraints {
            $0.width.equalTo(214 * scale)
            $0.height.equalTo(214 * scale)
            $0.top.equalToSuperview().offset(285 * scale)
            $0.left.equalToSuperview().offset(46 * scale)
        }
        
        imageView1.transform = imageView1.transform.rotated(by: 6 / 180.0 * CGFloat.pi)
        imageView1.snp.makeConstraints {
            $0.width.equalTo(214 * scale)
            $0.height.equalTo(214 * scale)
            $0.top.equalToSuperview().offset(74 * scale)
            $0.left.equalToSuperview().offset(92 * scale)
        }
    }
}

extension TemplateGradient: TemplateImageViewDelegate {
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

extension TemplateGradient: UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        var image: UIImage? = nil
        
        if let possibleImage = info[UIImagePickerController.InfoKey.editedImage] as? UIImage {
            image = possibleImage
        } else if let possibleImage = info[UIImagePickerController.InfoKey.originalImage] as? UIImage {
            image = possibleImage
        }
        
        if currentIndex == 0 {
            imageView1.image = image
        } else {
            imageView2.image = image
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
