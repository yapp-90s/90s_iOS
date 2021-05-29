//
//  StickerPackViewController.swift
//  90s
//
//  Created by woong on 2021/02/07.
//

import UIKit
import RxSwift

class StickerPackViewController: BaseViewController {
    
    private struct Constraints {
        static let navBarHeight: CGFloat = 65
        static let stickerSize: CGSize = .init(width: 50, height: 50)
        static let sectionInset: UIEdgeInsets = .init(top: 0, left: 19, bottom: 0, right: 18)
        static let interItemSpacing: CGFloat = 22
        static let lineSpacing: CGFloat = 20
    }
    
    // MARK: - Views
    
    private let backButton: HighlightButton = {
        let button = HighlightButton()
        button.setImage(UIImage(named: "ic_bottomArrow"), for: .normal)
        
        return button
    }()
    
    lazy private var navigationBar: PackNavigationBar = {
        let navBar = PackNavigationBar()
        navBar.addSideView(backButton, to: .left)
        navBar.titleLabel.textColor = .white
        navBar.titleLabel.font = .boldSystemFont(ofSize: 14)
        
        return navBar
    }()
    
    let stickerCollectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.sectionInset = Constraints.sectionInset
        layout.minimumInteritemSpacing = Constraints.interItemSpacing
        layout.minimumLineSpacing = Constraints.lineSpacing
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
        collectionView.backgroundColor = .clear
        
        return collectionView
    }()
    
    // MARK: - Properties
    
    var viewModel: StickerPackViewModel
    
    // MARK: - Initialize
    
    init(viewModel: StickerPackViewModel) {
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)
        
        bindViewModel()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .black
        setup()
        setupViews()
    }
    
    private func bindViewModel() {
        stickerCollectionView.rx.setDelegate(self).disposed(by: disposeBag)
        
        backButton.rx.tap
            .subscribe(onNext: { [unowned self] in
                self.dismiss(animated: true, completion: nil)
            })
            .disposed(by: disposeBag)
        
        viewModel.output.packName
            .bind(to: navigationBar.titleLabel.rx.text)
            .disposed(by: disposeBag)
        
        viewModel.output.stickers
            .bind(to: stickerCollectionView.rx.items) { (collectionView, item, sticker) -> UICollectionViewCell in
                let indexPath = IndexPath(item: item, section: 0)
                guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: StickerCollectionViewCell.identifier, for: indexPath) as? StickerCollectionViewCell else { return UICollectionViewCell() }
                cell.configure(sticker: sticker)
                return cell
            }
            .disposed(by: disposeBag)
    }
    
    private func setup() {
        stickerCollectionView.register(StickerCollectionViewCell.self, forCellWithReuseIdentifier: StickerCollectionViewCell.identifier)
    }
    
    private func setupViews() {
        view.backgroundColor = .warmGray
        
        view.addSubview(navigationBar)
        view.addSubview(stickerCollectionView)
        
        navigationBar.snp.makeConstraints {
            $0.top.leading.trailing.equalToSuperview()
            $0.height.equalTo(Constraints.navBarHeight)
        }
        
        stickerCollectionView.snp.makeConstraints {
            $0.top.equalTo(navigationBar.snp.bottom)
            $0.leading.trailing.bottom.equalToSuperview()
        }
    }
}

// MARK: - UICollectionViewDelegate

extension StickerPackViewController: UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        viewModel.input.addSticker.onNext(indexPath.item)
    }
}

// MARK: - UICollectionViewDelegateFlowLayout

extension StickerPackViewController: UICollectionViewDelegateFlowLayout {
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return Constraints.stickerSize
    }
}
