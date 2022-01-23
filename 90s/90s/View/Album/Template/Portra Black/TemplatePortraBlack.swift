//
//  TemplatePortraBlack.swift
//  Template
//
//  Created by 김진우 on 2021/08/21.
//

import UIKit

import SnapKit

final class TemplatePortraBlack: UIView, TemplateView {
    
    // MARK: - UI Component
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
    
    // MARK: - Property
    let scale = UIScreen.main.bounds.width / 323
    
    var isEditing: Bool = false {
        didSet {
            setEditing(isEditing)
        }
    }
    weak var delegate: TemplateViewDelegate?
    var currentIndex: Int = -1
    
    // MARK: - Init
    init() {
        super.init(frame: .zero)
        
        setLayout()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - Setup Method
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
    
    private func setEditing(_ isEditing: Bool) {
        imageView1.isUserInteractionEnabled = isEditing
        imageView2.isUserInteractionEnabled = isEditing
        imageView3.isUserInteractionEnabled = isEditing
        
        if isEditing {
            if imageView1.image == nil {
                imageView1.image = .init(named: "Icon_Add_Photo")
                imageView1.contentMode = .center
            }
            if imageView2.image == nil {
                imageView2.image = .init(named: "Icon_Add_Photo")
                imageView2.contentMode = .center
            }
            if imageView3.image == nil {
                imageView3.image = .init(named: "Icon_Add_Photo")
                imageView3.contentMode = .center
            }
        } else {
            imageView1.contentMode = .scaleAspectFit
            imageView2.contentMode = .scaleAspectFit
            imageView3.contentMode = .scaleAspectFit
        }
    }
    
    // MARK: - Interface
    func bind(page: Page) {
        for index in 0..<page.imagesURL.count {
            if index == 0 {
                imageView1.imageURL = page.imagesURL[index]
            } else if index == 1 {
                imageView2.imageURL = page.imagesURL[index]
            } else if index == 2 {
                imageView3.imageURL = page.imagesURL[index]
            }
        }
    }
}

extension TemplatePortraBlack: TemplateImageViewDelegate {
    func tapped(_ index: Int) {
        currentIndex = index
        delegate?.didTapPhoto(index: index)
    }
}
