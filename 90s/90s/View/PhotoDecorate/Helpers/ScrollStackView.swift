//
//  CategoryLabelsScrollView.swift
//  90s
//
//  Created by woong on 2021/02/20.
//

import UIKit

class ScrollStackView: UIScrollView {
    
    var spacing: CGFloat {
        didSet { contentStackView.spacing = spacing }
    }
    
    private(set) lazy var contentStackView: UIStackView = {
        let stackView = UIStackView()
        stackView.axis = .horizontal
        stackView.spacing = spacing
        stackView.alignment = .center
        
        return stackView
    }()

    init(views: [UIView], spacing: CGFloat = 30) {
        self.spacing = 30
        super.init(frame: .zero)
        self.showsHorizontalScrollIndicator = false
        self.showsVerticalScrollIndicator = false
        addSubview(contentStackView)
        contentStackView.snp.makeConstraints {
            $0.centerY.equalToSuperview()
            $0.leading.trailing.equalTo(self.contentLayoutGuide)
        }
        
        views.forEach { contentStackView.addArrangedSubview($0) }
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
