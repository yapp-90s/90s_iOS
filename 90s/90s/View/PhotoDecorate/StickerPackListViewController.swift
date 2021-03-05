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

    private let categoryListView: ScrollStackView = {
        let categoryLabels = StickerPackCategory.allCases.map { category -> CategoryLabel in
            let label = CategoryLabel(label: category.description)
            label.addTarget(self, action: #selector(touchedCategory), for: .touchUpInside)
            return label
        }
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
        view.addSubview(categoryListView)
    }
    
    private func setupLayouts() {
        categoryListView.snp.makeConstraints {
            $0.top.leading.trailing.equalToSuperview()
            $0.height.equalTo(Constraints.categoryLabelHeight + categoryListView.inset.top + categoryListView.inset.bottom)
        }
    }
    
    // MARK: - Methods
    
    @objc func touchedCategory(_ sender: CategoryLabel) {
        guard let index = StickerPackCategory.allCases.firstIndex(where: { $0.description == sender.label }) else { return }
        presentStickerPack(for: StickerPackCategory.allCases[index])
    }
    
    private func presentStickerPack(for category: StickerPackCategory) {
        let stickerPackVC = StickerPackViewController()
        stickerPackVC.modalPresentationStyle = .currentContext
        present(stickerPackVC, animated: true, completion: nil)
    }
}
