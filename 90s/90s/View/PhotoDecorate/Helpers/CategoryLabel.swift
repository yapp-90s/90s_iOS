//
//  CategoryLabel.swift
//  90s
//
//  Created by woong on 2021/02/20.
//

import UIKit

class CategoryLabel: HighlightButton {
    
    var label: String = "" {
        didSet {
            setTitle(label, for: .normal)
        }
    }
    
    init(label: String) {
        super.init(frame: .zero)
        self.label = label
        setTitle(label, for: .normal)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func setNeedsDisplay() {
        super.setNeedsDisplay()
        
        self.setTitleColor(.black, for: .normal)
    }
}
