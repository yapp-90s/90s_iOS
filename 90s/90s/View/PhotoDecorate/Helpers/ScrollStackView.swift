//
//  CategoryLabelsScrollView.swift
//  90s
//
//  Created by woong on 2021/02/20.
//

import UIKit

class ScrollStackView: UIScrollView {
    
    var inset: UIEdgeInsets {
        didSet {
            contentStackView.snp.updateConstraints {
                $0.edges.equalTo(self.contentLayoutGuide).inset(inset)
            }
        }
    }
    
    var spacing: CGFloat {
        didSet { contentStackView.spacing = spacing }
    }
    
    private(set) lazy var contentStackView: UIStackView = {
        let stackView = UIStackView()
        stackView.axis = .horizontal
        stackView.alignment = .fill
        stackView.spacing = spacing
        
        return stackView
    }()

    init(views: [UIView],
         spacing: CGFloat = 30,
         inset: UIEdgeInsets = .init(top: 0, left: 20, bottom: 0, right: -20)) {
        self.spacing = 30
        self.inset = inset
        super.init(frame: .zero)
        self.showsHorizontalScrollIndicator = false
        self.showsVerticalScrollIndicator = false
        addSubview(contentStackView)
        contentStackView.snp.makeConstraints {
            $0.edges.equalTo(self.contentLayoutGuide).inset(inset)
        }
        
        views.forEach { contentStackView.addArrangedSubview($0) }
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
