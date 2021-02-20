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
        static let categoryLabelHeight: CGFloat = 44 + categoryInset.bottom + categoryInset.top
        static let categorySpacing: CGFloat = 100
        static let categoryInset: UIEdgeInsets = .init(top: 10, left: 20, bottom: -10, right: -20)
    }
    
    // MARK: - Views
    
    private lazy var categoryScrollView: UIScrollView = {
        let scrollView = UIScrollView()
        scrollView.addSubview(categoryView)
        scrollView.showsHorizontalScrollIndicator = false
        scrollView.showsVerticalScrollIndicator = false
        
        return scrollView
    }()

    private var categoryView: UIView = {
        let view = UIView()
        
        return view
    }()
    
//    private var stickerPackListCollectionView: UICollectionView = {
//        let collectionView = UICollectionView()
//
//        return collectionView
//    }()
    
    private lazy var categoryStackView: UIStackView = {
        let stackView = UIStackView()
        stackView.axis = .horizontal
        stackView.alignment = .fill
        stackView.spacing = Constraints.categorySpacing
        categoryLabels.forEach { stackView.addArrangedSubview($0) }
        
        return stackView
    }()
    
    private var categoryLabels: [UILabel] = {
        return StickerPackCategory.allCases.map { category -> UILabel in
            let label = UILabel()
            label.text = category.description
            
            return label
        }
    }()
    
    private var contentSizeOfCategoryLabels: CGSize {
        return CGSize(width: categoryLabels.reduce(0, { $0 + $1.intrinsicContentSize.width }), height: Constraints.categoryLabelHeight)
    }
    
    
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
        view.addSubview(categoryScrollView)
        categoryScrollView.addSubview(categoryStackView)
    }
    
    private func setupLayouts() {
        categoryScrollView.snp.makeConstraints {
            $0.top.leading.trailing.equalToSuperview()
            $0.height.equalTo(Constraints.categoryLabelHeight)
        }
        
        categoryStackView.snp.makeConstraints {
            $0.edges.equalTo(categoryScrollView.contentLayoutGuide).inset(Constraints.categoryInset)
            $0.height.equalTo(categoryScrollView.contentLayoutGuide)
        }
    }
}
