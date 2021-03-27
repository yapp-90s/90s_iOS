//
//  AttachStickerView.swift
//  90s
//
//  Created by woong on 2021/03/06.
//

import UIKit

class ResizableStickerView: UIView {
    
    var resizeHandler: ((UIPanGestureRecognizer, ResizableStickerView) -> Void)?
    
    let removeButton: UIButton = {
        let button = UIButton()
        button.setImage(UIImage(named: "cancelButtonWhite"), for: .normal)
        button.addTarget(self, action: #selector(tappedRemoveButton(_:)), for: .touchUpInside)
        
        return button
    }()
    
    lazy private(set) var resizeButton: UIButton = {
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
        #if DEBUG
        print("sticker removed")
        #endif
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setupViews() {
        addSubview(imageView)
        addSubview(removeButton)
        addSubview(resizeButton)
        
        imageView.snp.makeConstraints {
            $0.edges.equalToSuperview().inset(20)
        }
        
        removeButton.snp.makeConstraints {
            $0.centerX.equalTo(imageView.snp.leading)
            $0.centerY.equalTo(imageView.snp.top)
            $0.width.equalTo(19)
            $0.height.equalTo(removeButton.snp.width)
        }
        
        resizeButton.snp.makeConstraints {
            $0.centerX.equalTo(imageView.snp.trailing)
            $0.centerY.equalTo(imageView.snp.bottom)
            $0.width.equalTo(19)
            $0.height.equalTo(resizeButton.snp.width)
        }
    }
    
    @objc private func resizePanGesture(_ sender: UIPanGestureRecognizer) {
        resizeHandler?(sender, self)
    }
    
    @objc private func tappedRemoveButton(_ sender: UIButton) {
        removeFromSuperview()
    }
    
    func resize(scale: CGFloat, angle: CGFloat, startTransform: CGAffineTransform, re: CGAffineTransform) {
        let newTransform = CGAffineTransform(scaleX: scale, y: scale).concatenating(CGAffineTransform(rotationAngle: angle))
        
        transform = startTransform.concatenating(newTransform)
        
        let reScale = 1 / scale
        removeButton.transform = re.concatenating(CGAffineTransform(scaleX: reScale, y: reScale))
        resizeButton.transform = re.concatenating(CGAffineTransform(scaleX: reScale, y: reScale))
    }
}
