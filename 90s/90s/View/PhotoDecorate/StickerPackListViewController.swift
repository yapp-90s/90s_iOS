//
//  StickerPackViewController.swift
//  90s
//
//  Created by woong on 2021/02/07.
//

import UIKit
import SnapKit
import RxSwift

class StickerPackListViewController: UIViewController {
    
    struct Constraints {
        static let categoryLabelHeight: CGFloat = 44
        static let categoryLabelsInset: UIEdgeInsets = .init(top: 0, left: 20, bottom: 0, right: -20)
    }
    
    // MARK: - Properties
    
    var viewModel = StickerPackViewModel(dependency: .init())
    var disposeBag = DisposeBag()
    
    // MARK: - Views
    
    private let categoryListView: ScrollStackView = {
        let categoryLabels = StickerPackCategory.allCases.map { category -> CategoryLabel in
            let label = CategoryLabel(label: category.description)
            label.addTarget(self, action: #selector(touchedCategory), for: .touchUpInside)
            return label
        }
        let scrollStackView = ScrollStackView(views: categoryLabels)
        scrollStackView.contentInset = Constraints.categoryLabelsInset
        
        return scrollStackView
    }()
    
    private let stickerPackCollectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.minimumInteritemSpacing = 8
        layout.scrollDirection = .horizontal
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
        
        return collectionView
    }()
    
    // MARK: - View Life Cycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setup()
        setupViews()
        setupLayouts()
        bindViewModel()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        navigationController?.setNavigationBarHidden(true, animated: false)
    }
    
    // MARK: - Initialize
    
    private func setup() {
        stickerPackCollectionView.register(StickerPackCollectionViewCell.self, forCellWithReuseIdentifier: StickerPackCollectionViewCell.identifier)
    }
    
    private func setupViews() {
        view.addSubview(categoryListView)
        view.addSubview(stickerPackCollectionView)
    }
    
    private func setupLayouts() {
        categoryListView.snp.makeConstraints {
            $0.top.leading.trailing.equalToSuperview()
            $0.height.equalTo(Constraints.categoryLabelHeight)
        }
        
        stickerPackCollectionView.snp.makeConstraints {
            $0.top.equalTo(categoryListView.snp.bottom)
            $0.leading.trailing.bottom.equalToSuperview()
        }
    }
    
    private func bindViewModel() {
        
        stickerPackCollectionView.rx.setDelegate(self).disposed(by: disposeBag)
        
        viewModel.output.currentCategory
            .subscribe(onNext: { [weak self] category in
                self?.selectCategory(to: category)
            })
            .disposed(by: disposeBag)
        
        viewModel.output.stickerPackList
            .bind(to: stickerPackCollectionView.rx.items) { (collectionView, item, stickerPack) -> UICollectionViewCell in
                let indexPath = IndexPath(item: item, section: 0)
                guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: StickerPackCollectionViewCell.identifier, for: indexPath) as? StickerPackCollectionViewCell else { return UICollectionViewCell() }
                cell.configure(pack: stickerPack)
                return cell
            }
            .disposed(by: disposeBag)
    }
    
    // MARK: - Methods
    
    @objc private func touchedCategory(_ sender: CategoryLabel) {
        guard let index = StickerPackCategory.allCases.firstIndex(where: { $0.description == sender.label }) else { return }
        viewModel.input.selectCategory.onNext(StickerPackCategory.allCases[index])
    }
    
    private func selectCategory(to category: StickerPackCategory) {
        categoryListView.contentStackView.subviews.forEach {
            guard let categoryLabel = $0 as? CategoryLabel else { return }
            categoryLabel.isSelected = categoryLabel.text == category.description
        }
    }
    
    private func presentStickerPack(for StickerPack: StickerPack) {
        let stickerPackVC = StickerPackViewController()
        stickerPackVC.modalPresentationStyle = .currentContext
        present(stickerPackVC, animated: true, completion: nil)
    }
}

extension StickerPackListViewController: UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        
        presentStickerPack(for: <#T##StickerPackCategory#>)
    }
}

extension StickerPackListViewController: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return .init(width: 92, height: 140)
    }
}
