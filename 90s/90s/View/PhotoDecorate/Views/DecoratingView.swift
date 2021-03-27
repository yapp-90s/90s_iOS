//
//  DecoratingView.swift
//  90s
//
//  Created by woong on 2021/03/06.
//

import UIKit
import RxSwift

class DecoratingView: UIView {
    
    // MARK: Properties
    
    private var decorator = StickerDecorator()
    
    // MARK: - Methods
    
    func attachStickerView(_ sticker: ResizableStickerView, at position: CGPoint? = nil) {
        addSubview(sticker)
        sticker.center = position ?? center
        addMovingGesture(sticker)
        addResizingGesture(sticker)
    }
    
    // MARK: Private
    
    private func addMovingGesture(_ sticker: ResizableStickerView) {
        let panGesture = UIPanGestureRecognizer(target: self, action: #selector(moveSticker(_:)))
        
        sticker.addGestureRecognizer(panGesture)
    }
    
    private func addResizingGesture(_ sticker: ResizableStickerView) {
        sticker.resizeHandler = { [weak self] gesture, sticker in
            self?.panGestureResizing(sticker, with: gesture)
        }
    }
    
    @objc private func moveSticker(_ gesture: UIPanGestureRecognizer) {
        decorator.moveSticker(with: gesture, in: self)
    }
    
    private func panGestureResizing(_ sticker: ResizableStickerView, with gesture: UIPanGestureRecognizer) {
        decorator.resizingSticker(sticker, with: gesture, in: self)
    }
}
