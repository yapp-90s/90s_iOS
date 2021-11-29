//
//  AlbumListViewController.swift
//  90s
//
//  Created by 김진우 on 2021/11/20.
//

import UIKit
import RxSwift
import RxCocoa
import SnapKit
import RxDataSources

final class AlbumListViewController: UIViewController {
    
    private let albumHeightScale: CGFloat = 1.172839
    
    typealias AlbumSectionModel = SectionModel<String, AlbumViewModel>
    typealias AlbumDataSource = RxCollectionViewSectionedReloadDataSource<AlbumSectionModel>
    
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
        label.text = "내 앨범"
        label.font = .Top_Title
        label.textColor = .white
        topBar.addSubview(label)
        return label
    }()
    
    private lazy var editButton: UIButton = {
        let button = UIButton()
        button.setTitle("편집", for: .normal)
        button.setTitleColor(.white, for: .normal)
//        button.titleLabel?.font = .
        topBar.addSubview(button)
        return button
    }()
    
    private lazy var collectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.sectionInset = .init(top: 31 * layoutScale, left: 18 * layoutScale, bottom: 31 * layoutScale, right: 18 * layoutScale)
        layout.minimumInteritemSpacing = 15 * layoutScale
        layout.minimumLineSpacing = 20 * layoutScale
        let width = (UIScreen.main.bounds.width - 52 * layoutScale) / 2
        layout.itemSize = .init(width: width, height: width * albumHeightScale)
        let collectionView = UICollectionView(frame: view.bounds, collectionViewLayout: layout)
        
        collectionView.register(AlbumCoverCell.self, forCellWithReuseIdentifier: AlbumCoverCell.identifier)
        
        collectionView.translatesAutoresizingMaskIntoConstraints = false
        
        view.addSubview(collectionView)
        
        return collectionView
    }()
    
    // MARK: - Property
    private let viewModel: AlbumListViewModel
    private let disposeBag = DisposeBag()
    
    init(viewModel: AlbumListViewModel) {
        self.viewModel = viewModel
        
        super.init(nibName: nil, bundle: nil)
        setupUI()
        bindState()
        bindAction()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK; - Method
    private func setupUI() {
        view.backgroundColor = .black
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
        
        editButton.snp.makeConstraints {
            $0.width.height.equalTo(34 * layoutScale)
            $0.trailing.equalToSuperview().offset(-9 * layoutScale)
            $0.centerY.equalToSuperview()
        }
        
        collectionView.snp.makeConstraints {
            $0.top.equalTo(topBar.snp.bottom)
            $0.leading.bottom.trailing.equalToSuperview()
        }
    }
    
    private func bindState() {
        let dataSource = AlbumDataSource(configureCell: { _, colelctionView, indexPath, viewModel in
            let cell = self.collectionView.dequeueReusableCell(withReuseIdentifier: AlbumCoverCell.identifier, for: indexPath) as! AlbumCoverCell
            cell.viewModel = viewModel
            return cell
        })
        viewModel.output.albumSection
            .bind(to: collectionView.rx.items(dataSource: dataSource))
            .disposed(by: disposeBag)
        
        viewModel.output.edit
            .bind { isEdit in
                
            }
            .disposed(by: disposeBag)
        
        viewModel.output.back
            .bind { _ in
                self.dismiss()
            }
            .disposed(by: disposeBag)
    }
    
    private func bindAction() {
        backButton.rx.tap
            .bind(to: viewModel.input.back)
            .disposed(by: disposeBag)
        
        editButton.rx.tap
            .bind(to: viewModel.input.edit)
            .disposed(by: disposeBag)
        
        collectionView.rx.itemSelected
            .bind(to: viewModel.input.selectAlbum)
            .disposed(by: disposeBag)
    }
    
    private func dismiss() {
        DispatchQueue.main.async {
            self.navigationController?.popViewController(animated: true)
        }
    }
}
