//
//  StickerPackViewController.swift
//  90s
//
//  Created by woong on 2021/02/07.
//

import UIKit
import SnapKit
import RxSwift

class StickerPackListViewController: BaseViewController {
    
    struct Constraints {
        static let categoryLabelHeight: CGFloat = 44
        static let categoryLabelsInset: UIEdgeInsets = .init(top: 0, left: 20, bottom: 0, right: -20)
        static let packSize: CGSize = .init(width: 92, height: 140)
        static let sectionInset: UIEdgeInsets = .init(top: 0, left: 20, bottom: 0, right: 20)
    }
    
    // MARK: - Properties
    
    unowned let viewModel: StickerPackListViewModel
    
    // MARK: - Views
    
    private let categoryListView: ScrollingHorizontalStackView = {
        let categoryLabels = StickerPackCategory.allCases.map { category -> CategoryLabel in
            let label = CategoryLabel(label: category.description)
            label.addTarget(self, action: #selector(touchedCategory), for: .touchUpInside)
            return label
        }
        let scrollStackView = ScrollingHorizontalStackView(views: categoryLabels)
        scrollStackView.contentInset = Constraints.categoryLabelsInset
        
        return scrollStackView
    }()
    
    private let stickerPackCollectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.minimumInteritemSpacing = 8
        layout.scrollDirection = .horizontal
        layout.sectionInset = Constraints.sectionInset
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
        collectionView.backgroundColor = .clear
        
        return collectionView
    }()
    
    // MARK: - View Life Cycle
    
    init(_ viewModel: StickerPackListViewModel) {
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
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
        
        viewModel.output.showStickersOfPack
            .subscribe(onNext: { [weak self] pack in
                self?.presentStickerPack(for: pack)
            })
            .disposed(by: disposeBag)
    }
    
    // MARK: - Methods
    
    @objc private func touchedCategory(_ sender: CategoryLabel) {
        guard let index = StickerPackCategory.allCases.firstIndex(where: { $0.description == sender.label }) else { return }
        viewModel.input.selectedCategory.onNext(StickerPackCategory.allCases[index])
    }
    
    private func selectCategory(to category: StickerPackCategory) {
        categoryListView.contentStackView.subviews.forEach {
            guard let categoryLabel = $0 as? CategoryLabel else { return }
            categoryLabel.isSelected = categoryLabel.text == category.description
        }
    }
    
    private func presentStickerPack(for stickerPack: StickerPackType) {
        self.definesPresentationContext = true
        let stickerPackVC = StickerPackViewController(viewModel: StickerPackViewModel(dependency: .init(photoDecorateViewModel: viewModel.dependency.photoDecorateViewModel,
                                                                                                        stickerPack: stickerPack)))
        stickerPackVC.modalPresentationStyle = .currentContext
        present(stickerPackVC, animated: true, completion: nil)
    }
}

extension StickerPackListViewController: UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        viewModel.input.selectedStickerPack.onNext(indexPath.item)
    }
}

extension StickerPackListViewController: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return Constraints.packSize
    }
}
