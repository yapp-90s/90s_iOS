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
            default: break
        }
    }
    
    func renderDecoratedView(_ decoratedView: UIView, in backgroundRect: CGRect) -> Data {
        self.setStickers(rendering: true, on: decoratedView)
        let renderer = UIGraphicsImageRenderer(size: decoratedView.bounds.size)
        let image = renderer.pngData { context in
            decoratedView.drawHierarchy(in: backgroundRect, afterScreenUpdates: true)
        }
        self.setStickers(rendering: false, on: decoratedView)
        
        return image
    }
    
    private func setStickers(rendering: Bool, on decoratedView: UIView) {
        func recursiveStickerRendering(in view: UIView) {
            if let sticker = view as? ResizableStickerView {
                sticker.isRendering = rendering
            } else {
                for subView in view.subviews {
                    recursiveStickerRendering(in: subView)
                }
            }
        }
        recursiveStickerRendering(in: decoratedView)
    }
    
    private func resizeStickerAndButtons(sticker: ResizableStickerView, scale: CGFloat, angle: CGFloat) {
        let newTransform = CGAffineTransform(scaleX: scale, y: scale).concatenating(CGAffineTransform(rotationAngle: angle))
        
        sticker.transform = startTransform.concatenating(newTransform)
        
        let reScale = 1 / scale
        sticker.removeButton.transform = buttonTransform.concatenating(CGAffineTransform(scaleX: reScale, y: reScale))
        sticker.resizeButton.transform = buttonTransform.concatenating(CGAffineTransform(scaleX: reScale, y: reScale))
    }
}
