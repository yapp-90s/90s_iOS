//
//  HighlightButton.swift
//  90s
//
//  Created by woong on 2021/03/05.
//

import UIKit

class HighlightButton: UIButton {

    override var isHighlighted: Bool {
        willSet {
            newValue ? highlight() : unHighlight()
        }
    }
    
    func configureHighlight(alpha: CGFloat, duration: TimeInterval) {
        self.highlightAlpha = alpha
        self.highlightDuration = duration
    }
    
    // MARK: - Private for highlight
    
    private lazy var normalAlpha: CGFloat = alpha
    private(set) var highlightAlpha: CGFloat = 0.4
    private(set) var highlightDuration: TimeInterval = 0.1
    
    private func highlight() {
        normalAlpha = alpha
        animate(alpha: highlightAlpha, duration: highlightDuration)
    }

    private func unHighlight() {
        animate(alpha: normalAlpha, duration: highlightDuration)
    }
    
    private func animate(alpha: CGFloat, duration: TimeInterval) {
        UIView.animate(withDuration: duration) {
            self.alpha = alpha
        }
    }
}
