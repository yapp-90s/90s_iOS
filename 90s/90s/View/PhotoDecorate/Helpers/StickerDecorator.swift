//
//  StickerDecorator.swift
//  90s
//
//  Created by woong on 2021/03/27.
//

import UIKit

class StickerDecorator {
    
    private var startPoint: CGPoint = .zero
    private var startTransform: CGAffineTransform = .init()
    private var buttonTransform: CGAffineTransform = .init()
    
    func moveSticker(with gesture: UIPanGestureRecognizer, in backgroundView: UIView) {
        guard let sticker = gesture.view as? ResizableStickerView else { return }
        switch gesture.state {
            case .changed:
                let location = gesture.location(in: backgroundView)
                if backgroundView.bounds.contains(sticker.bounds) {
                    sticker.center = location
                }
            default: break
        }
    }
    
    func resizingSticker(_ sticker: ResizableStickerView, with gesture: UIPanGestureRecognizer, in backgroundView: UIView) {
        switch gesture.state {
            case .began:
                startPoint = gesture.location(in: backgroundView)
                startTransform = sticker.transform
                buttonTransform = sticker.resizeButton.transform
                sticker.isEditing = true
//                sticker.resizeButton.isHighlighted = true
//                sticker.removeButton.isHidden = true
            case .changed:
                sticker.resizeButton.isHighlighted = true
                let current = gesture.location(in: backgroundView)
                let distCurr = sticker.center.distance(to: current)
                let distStart = sticker.center.distance(to: startPoint)
                let scale = distCurr / distStart
                
                let currentAngle = sticker.center.absoulteAngle(to: current)
                let startAngle = sticker.center.absoulteAngle(to: startPoint)
                let angle = currentAngle - startAngle
                resizeStickerAndButtons(sticker: sticker, scale: scale, angle: angle)
            case .ended, .cancelled:
                sticker.isEditing = false
//                sticker.resizeButton.isHighlighted = false
//                sticker.removeButton.isHidden = false
            default: break
        }
    }
    
    private func resizeStickerAndButtons(sticker: ResizableStickerView, scale: CGFloat, angle: CGFloat) {
        let newTransform = CGAffineTransform(scaleX: scale, y: scale).concatenating(CGAffineTransform(rotationAngle: angle))
        
        sticker.transform = startTransform.concatenating(newTransform)
        
        let reScale = 1 / scale
        sticker.removeButton.transform = buttonTransform.concatenating(CGAffineTransform(scaleX: reScale, y: reScale))
        sticker.resizeButton.transform = buttonTransform.concatenating(CGAffineTransform(scaleX: reScale, y: reScale))
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
