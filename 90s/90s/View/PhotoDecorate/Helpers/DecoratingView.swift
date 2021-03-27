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
    private var startTransform: CGAffineTransform = .init()
    private var buttonTransform: CGAffineTransform = .init()
    
    @IBAction private func panGestureResizing(_ sticker: ResizableStickerView, with gesture: UIPanGestureRecognizer) {
        
        switch gesture.state {
            case .began:
                startPoint = gesture.location(in: self)
                startTransform = sticker.transform
                buttonTransform = sticker.resizeButton.transform
                sticker.resizeButton.isHighlighted = true
                sticker.removeButton.isHidden = true
            case .changed:
                sticker.resizeButton.isHighlighted = true
                let current = gesture.location(in: self)
                let distCurr = sticker.center.distance(to: current)
                let distStart = sticker.center.distance(to: startPoint)
                let scale = distCurr / distStart
                
                let currentAngle = sticker.center.absoulteAngle(to: current)
                let startAngle = sticker.center.absoulteAngle(to: startPoint)
                let angle = currentAngle - startAngle
                
                sticker.resize(scale: scale, angle: angle, startTransform: startTransform, re: buttonTransform)
            case .ended, .cancelled:
                sticker.resizeButton.isHighlighted = false
                sticker.removeButton.isHidden = false
            default: break
        }
    }
}

extension CGPoint {
    func distance(to point: CGPoint) -> CGFloat {
        let distX = x - point.x
        let distY = y - point.y
        return (distX * distX + distY * distY).squareRoot()
    }
    
    func absoulteAngle(to point: CGPoint) -> CGFloat {
        return atan2(y - point.y, x - point.x)
    }
}
