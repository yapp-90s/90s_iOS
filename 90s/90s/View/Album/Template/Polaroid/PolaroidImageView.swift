//
//  PolaroidImageView.swift
//  Template
//
//  Created by 김진우 on 2021/10/16.
//

import UIKit

final class PolaroidImageView: UIView, TemplateImageView {
    
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
        imageView.image = UIImage(named: "Frame_Polaroid")
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
        fatalError("init(coder:) has not been Frame_Polaroid")
    }
    
    // MARK: - Setup Method
    private func setAction() {
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(tap(_:)))
        caseImageView.addGestureRecognizer(tapGesture)
    }
    
    private func setLayout() {
        imageView.snp.makeConstraints {
            $0.top.left.equalToSuperview().offset(10)
            $0.right.equalToSuperview().offset(-10)
            $0.bottom.equalToSuperview().offset(-34)
        }
        
        caseImageView.snp.makeConstraints {
            $0.top.left.bottom.right.equalToSuperview()
        }
    }
    
    // MARK: - Action Method
    @objc private func tap(_ sender: UITapGestureRecognizer) {
        delegate?.tapped(tag)
    }
}
