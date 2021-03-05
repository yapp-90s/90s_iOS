//
//  StickerPackViewController.swift
//  90s
//
//  Created by woong on 2021/02/07.
//

import UIKit
import SnapKit

class StickerPackListViewController: UIViewController {
    
    struct Constraints {
        static let categoryLabelHeight: CGFloat = 44
    }
    
    // MARK: - Views

    private let scrollStackView: ScrollStackView = {
        let categoryLabels = StickerPackCategory.allCases.map { CategoryLabel(label: $0.description) }
        let scrollStackView = ScrollStackView(views: categoryLabels)
        
        return scrollStackView
    }()
    
    // MARK: - View Life Cycle

    override func viewDidLoad() {
        super.viewDidLoad()
        setup()
        setupViews()
        setupLayouts()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        navigationController?.setNavigationBarHidden(true, animated: false)
    }
    
    // MARK: - Initialize
    
    private func setup() {
        view.backgroundColor = .systemBackground
    }
    
    private func setupViews() {
        view.addSubview(scrollStackView)
    }
    
    private func setupLayouts() {
        scrollStackView.snp.makeConstraints {
            $0.top.leading.trailing.equalToSuperview()
            $0.height.equalTo(Constraints.categoryLabelHeight + scrollStackView.inset.top + scrollStackView.inset.bottom)
        }
    }
}
