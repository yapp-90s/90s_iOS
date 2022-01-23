//
//  PortraWhiteImageView.swift
//  Template
//
//  Created by 김진우 on 2021/08/21.
//

import UIKit
import Kingfisher

final class PortraWhiteTemplateImageView: UIView, TemplateImageView {
    
    // MARK: - UI Component
    lazy var imageView: UIImageView = {
        let imageView = UIImageView()
        imageView.clipsToBounds = true
        imageView.backgroundColor = .Cool_Gray
        imageView.contentMode = .scaleAspectFill
        addSubview(imageView)
        return imageView
    }()
    
    lazy var caseImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.image = UIImage(named: "Frame_FilmW")
        imageView.isUserInteractionEnabled = true
        imageView.contentMode = .scaleToFill
        addSubview(imageView)
        return imageView
    }()
    
    // MARK: - Property
    var image: UIImage? {
        didSet {
            imageView.image = self.image
        }
    }
    
    var imageURL: URL? {
        didSet {
            imageView.kf.setImage(with: imageURL)
        }
    }
    
    weak var delegate: TemplateImageViewDelegate?
    
    // MARK: - Init
    init() {
        super.init(frame: .zero)
        
        setLayout()
        setAction()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - Setup Method
    private func setAction() {
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(tap(_:)))
        caseImageView.addGestureRecognizer(tapGesture)
    }
    
    private func setLayout() {
        imageView.snp.makeConstraints {
            $0.top.left.bottom.right.equalToSuperview()
        }
        
        caseImageView.snp.makeConstraints {
            $0.top.left.bottom.right.equalToSuperview()
        }
    }
    
    // MARK: - Action Method
    @objc func tap(_ sender: UITapGestureRecognizer) {
        delegate?.tapped(tag)
    }
}
