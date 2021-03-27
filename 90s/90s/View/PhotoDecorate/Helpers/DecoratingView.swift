//
//  DecoratingView.swift
//  90s
//
//  Created by woong on 2021/03/06.
//

import UIKit
import RxSwift

class DecoratingView: UIView {
    
    var disposeBag = DisposeBag()
    
    func attachStickerView(_ sticker: ResizableStickerView, at position: CGPoint? = nil) {
        addSubview(sticker)
        sticker.center = position ?? center
        addMovingGesture(sticker)
        addResizingGesture(sticker)
    }
    
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
        switch gesture.state {
            case .changed:
                guard let sticker = gesture.view as? ResizableStickerView else { return }
                let location = gesture.location(in: self)
                if self.bounds.contains(sticker.bounds) {
                    sticker.center = location
                }
            default: break
        }
    }
    
    private var startPoint: CGPoint = .zero
    private var startAngle: CGFloat = .zero
    
    @IBAction func panGestureResizing(_ sticker: ResizableStickerView, with gesture: UIPanGestureRecognizer) {

        switch gesture.state {
            case .began:
                startPoint = gesture.location(in: self)
                sticker.resizeButton.isHighlighted = true
            case .changed:
                sticker.resizeButton.isHighlighted = true
                let current = gesture.location(in: self)

                let scale = current.x / startPoint.x
                let scaleAffine = CGAffineTransform(scaleX: scale, y: scale)
                
                let startAngle = atan2(startPoint.y - sticker.center.y, startPoint.x - sticker.center.x)
                let currentAngle = atan2(current.y - sticker.center.y, current.x - sticker.center.x)
                let angle = currentAngle - startAngle
                let rotationAffine = CGAffineTransform(rotationAngle: angle)
                sticker.transform = scaleAffine.concatenating(rotationAffine)
            
            case .ended, .cancelled:
                sticker.resizeButton.isHighlighted = false
            default: break
        }
    }
}
