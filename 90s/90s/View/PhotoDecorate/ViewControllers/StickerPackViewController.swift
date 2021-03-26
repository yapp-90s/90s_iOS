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
        static let navBarHeight: CGFloat = 44
        static let stickerSize: CGSize = .init(width: 50, height: 50)
    }
    
    // MARK: - Properties
    
    var viewModel: StickerPackViewModel
    
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
        
        return navBar
    }()
    
    let stickerCollectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
        
        return collectionView
    }()

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

extension StickerPackViewController: UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        viewModel.input.addSticker.onNext(indexPath.item)
    }
}

extension StickerPackViewController: UICollectionViewDelegateFlowLayout {
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return Constraints.stickerSize
    }
}
