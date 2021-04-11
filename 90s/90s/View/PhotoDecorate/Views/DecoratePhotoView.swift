//
//  PhotoView.swift
//  90s
//
//  Created by woong on 2021/03/06.
//

import UIKit
import SnapKit

class DecoratePhotoView: UIView {

    // MARK: - Views

    var imageView: UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFill

        return imageView
    }()

    // MARK: - Properties
    
    var photoInset: UIEdgeInsets = .init(top: 20, left: 20, bottom: 20, right: 20)
    private var imageHeightRatio: CGFloat = 1.0
    var heightConstarint: SnapKit.ConstraintItem?
    
    var image: UIImage? {
        get {
            return imageView.image
        }
        set {
            guard let image = newValue else { return }
            
            let heightRatio = image.size.height / image.size.width
            print(heightRatio)
            imageView.image = newValue
            // photoBackgroundView.snp.remakeConstraints({ $0.height.equalTo(photoBackgroundView.snp.width).multipliedBy(heightRatio) })
//            let newSize = CGSize(width: <#T##CGFloat#>, height: <#T##CGFloat#>)
            
            // imageView.snp.remakeConstraints({ $0.height.equalTo(imageView.snp.width).multipliedBy(ratio) })
             // imageView.image = newValue
        }
    }

    // MARK: Initialize

    init() {
        super.init(frame: .zero)
        setupViews()
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setupViews() {
        backgroundColor = .white
        addSubview(imageView)
        
        imageView.snp.makeConstraints {
            $0.edges.equalToSuperview().inset(photoInset)
        }
    }
}
