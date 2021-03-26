//
//  AttachStickerView.swift
//  90s
//
//  Created by woong on 2021/03/06.
//

import UIKit

class AttachStickerView: UIView {
    
    var resizeHandler: ((UIPanGestureRecognizer, AttachStickerView) -> Void)?
    
    let removeButton: UIButton = {
        let button = UIButton()
        button.setImage(UIImage(named: "cancelButtonWhite"), for: .normal)

        return button
    }()
    
    lazy var resizeButton: UIButton = {
        let button = UIButton()
        button.setImage(UIImage(named: "stckerControlSize"), for: .normal)
        button.addGestureRecognizer(UIPanGestureRecognizer(target: self, action: #selector(resizePanGesture(_:))))
        
        return button
    }()

    let imageView: UIImageView = {
        let imageView = UIImageView()
        
        return imageView
    }()
    
    init(image: UIImage?) {
        super.init(frame: .init(x: 0, y: 0, width: 100, height: 100))
        imageView.image = image
        setupViews()
    }
    
    deinit {
        print("removed")
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setupViews() {
        addSubview(imageView)
        addSubview(removeButton)
        addSubview(resizeButton)
        
        removeButton.snp.makeConstraints {
            $0.top.leading.equalToSuperview()
            $0.width.equalTo(19)
            $0.height.equalTo(removeButton.snp.width)
        }
        
        resizeButton.snp.makeConstraints {
            $0.trailing.bottom.equalToSuperview()
            $0.width.equalTo(19)
            $0.height.equalTo(resizeButton.snp.width)
        }
        
        imageView.snp.makeConstraints {
            $0.top.equalTo(removeButton.snp.bottom)
            $0.leading.equalTo(removeButton.snp.trailing)
            $0.trailing.equalTo(resizeButton.snp.leading)
            $0.bottom.equalTo(resizeButton.snp.top)
        }
    }
    
    @objc private func resizePanGesture(_ sender: UIPanGestureRecognizer) {
        resizeHandler?(sender, self)
    }
}
