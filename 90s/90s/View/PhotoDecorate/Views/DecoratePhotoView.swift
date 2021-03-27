//
//  PhotoView.swift
//  90s
//
//  Created by woong on 2021/03/06.
//

import UIKit

class DecoratePhotoView: UIView {
    
    // MARK: - Views
    
    var photoBackgroundView: UIView = {
        let view = UIView()
        view.backgroundColor = .white
        
        return view
    }()
    
    var imageView: UIImageView = {
        let imageView = UIImageView()
        
        return imageView
    }()
    
    // MARK: - Properties
    
    var photoInset: UIEdgeInsets = .init(top: 20, left: 20, bottom: 20, right: 20)
    var image: UIImage? {
        get {
            return imageView.image
        }
        set {
            imageView.image = newValue
        }
    }
    
    // MARK: Initialize
    
    init(image: UIImage?) {
        super.init(frame: .zero)
        imageView.image = image
        setupViews()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setupViews() {
        addSubview(photoBackgroundView)
        photoBackgroundView.addSubview(imageView)
        
        photoBackgroundView.snp.makeConstraints {
            $0.edges.equalToSuperview()
        }
        
        imageView.snp.makeConstraints {
            $0.edges.equalToSuperview().inset(photoInset)
        }
    }
}
