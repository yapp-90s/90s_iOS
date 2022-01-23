//
//  AlbumDetailCollectionViewController.swift
//  90s
//
//  Created by 김진우 on 2022/01/22.
//

import UIKit

import RxSwift
import RxCocoa
import SnapKit
import RxDataSources

final class AlbumDetailCollectionViewController: UIViewController {
    
    // MARK: - UI Component
    private lazy var topBar: UIView = {
        let view = UIView()
        self.view.addSubview(view)
        return view
    }()
    
    private lazy var backButton: UIButton = {
        let button = UIButton()
        button.setImage(.init(named: "navigationBar_back"), for: .normal)
        topBar.addSubview(button)
        return button
    }()
    
    private lazy var titleLabel: UILabel = {
        let label = UILabel()
        label.font = .topTitle
        label.textColor = .white
        topBar.addSubview(label)
        return label
    }()
    
    private lazy var closeButton: UIButton = {
        let button = UIButton()
        button.setImage(.init(named: "navigationBar_close"), for: .normal)
        topBar.addSubview(button)
        return button
    }()
    
    private lazy var collectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.sectionInset = .init(top: 22 * layoutScale, left: 18 * layoutScale, bottom: 22 * layoutScale, right: 18 * layoutScale)
        layout.minimumLineSpacing = 11 * layoutScale
        layout.minimumInteritemSpacing = 11 * layoutScale
        layout.scrollDirection = .vertical
        let width = UIScreen.main.bounds.width - 47 * layoutScale
        layout.itemSize = .init(width: width, height: width)
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
        collectionView.register(TemplateCell.self, forCellWithReuseIdentifier: TemplateCell.identifier)
        collectionView.translatesAutoresizingMaskIntoConstraints = false
        
        view.addSubview(collectionView)
        
        return collectionView
    }()
    
    // MARK: - Property
    private let viewModel: AlbumDetailCollectionViewModel
    private let disposeBag = DisposeBag()
    
    // MARK: - Init
    init(viewModel: AlbumDetailCollectionViewModel) {
        self.viewModel = viewModel
        
        super.init(nibName: nil, bundle: nil)
        
        setupUI()
        bindState()
        bindAction()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setupUI() {
        topBar.snp.makeConstraints {
            $0.height.equalTo(52 * layoutScale)
            $0.top.equalTo(view.safeAreaLayoutGuide.snp.top)
            $0.leading.trailing.equalToSuperview()
        }
        
        backButton.snp.makeConstraints {
            $0.width.height.equalTo(34 * layoutScale)
            $0.leading.equalToSuperview().offset(9 * layoutScale)
            $0.centerY.equalToSuperview()
        }

        titleLabel.snp.makeConstraints {
            $0.height.equalTo(24 * layoutScale)
            $0.center.equalToSuperview()
        }

        closeButton.snp.makeConstraints {
            $0.width.height.equalTo(34 * layoutScale)
            $0.trailing.equalToSuperview().offset(-9 * layoutScale)
            $0.centerY.equalToSuperview()
        }
        
        collectionView.snp.makeConstraints {
            $0.top.equalTo(topBar.snp.bottom)
            $0.leading.trailing.equalToSuperview()
            $0.bottom.equalTo(view.safeAreaLayoutGuide.snp.bottom)
        }
    }
    
    private func bindState() {
        
    }
    
    private func bindAction() {
        
    }
}
