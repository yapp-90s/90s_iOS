//
//  CategoryLabel.swift
//  90s
//
//  Created by woong on 2021/02/20.
//

import UIKit

class CategoryLabel: HighlightButton {
    
    var text: String {
        return titleLabel?.text ?? ""
    }
    
    var label: String = "" {
        didSet {
            setTitle(label, for: .normal)
        }
    }
    
    override var isSelected: Bool {
        didSet {
            setTitleColor(.white, for: .selected)
            setTitleColor(.lightGray, for: .normal)
        }
    }
    
    init(label: String) {
        super.init(frame: .zero)
        self.label = label
        setTitle(label, for: .normal)
        setTitleColor(.lightGray, for: .normal)
        setTitleColor(.white, for: .selected)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func setNeedsDisplay() {
        super.setNeedsDisplay()
        
        self.setTitleColor(.black, for: .normal)
    }
}
