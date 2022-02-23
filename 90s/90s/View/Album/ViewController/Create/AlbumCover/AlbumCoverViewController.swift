//
//  AlbumCreateCoverViewController.swift
//  90s
//
//  Created by 김진우 on 2021/04/10.
//

import UIKit
import RxSwift
import RxCocoa
import SnapKit
import RxDataSources

class AlbumCoverViewController: UIViewController {
    
    // MARK: - UI Component
    private lazy var topBar: UIView = {
        let view = UIView()
        self.view.addSubview(view)
        return view
    }()
    
    private lazy var titleLabel: UILabel = {
        let label = UILabel()
        topBar.addSubview(label)
        label.text = "앨범 만들기(1/3)"
        label.font = .subHead
        return label
    }()
    
    private lazy var closeButton: UIButton = {
        let button = UIButton()
        button.setImage(.init(named: "navigationBar_close"), for: .normal)
        topBar.addSubview(button)
        return button
    }()
    
    private lazy var descriptionLabel: UILabel = {
        let label = UILabel()
        label.numberOfLines = 2
        label.font = .subHead
        label.text = "앨범의 얼굴,\n커버를 선택해 주세요"
        self.view.addSubview(label)
        return label
    }()
    
    private lazy var coverImageView: UIImageView = {
        let imageView = UIImageView()
        self.view.addSubview(imageView)
        return imageView
    }()
    
    private lazy var collectionViewLayout: UICollectionViewLayout = {
        let layout = UICollectionViewCompositionalLayout { (sectionIndex, environment) -> NSCollectionLayoutSection? in
            let itemSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1), heightDimension: .fractionalHeight(1))
            let item = NSCollectionLayoutItem(layoutSize: itemSize)
            
            let groupSize = NSCollectionLayoutSize(widthDimension: .absolute(118 * layoutScale), heightDimension: .absolute(118 * layoutScale))
            let group = NSCollectionLayoutGroup.vertical(layoutSize: groupSize, subitems: [item])
            
            let section = NSCollectionLayoutSection(group: group)
            section.orthogonalScrollingBehavior = .continuous
            section.interGroupSpacing = .init(16 * layoutScale)
            section.contentInsets = .init(top: 0, leading: 18 * layoutScale, bottom: 0, trailing: 18 * layoutScale)
            
            return section
        }
        return layout
    }()
    
    private lazy var collectionView: UICollectionView = {
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: collectionViewLayout)
        
        collectionView.register(CoverImageCell.self, forCellWithReuseIdentifier: CoverImageCell.identifier)
        collectionView.translatesAutoresizingMaskIntoConstraints = false
        
        self.view.addSubview(collectionView)
        
        return collectionView
    }()
    
    private lazy var button: UIButton = {
        let button = UIButton()
        button.backgroundColor = .retroOrange
        button.layer.cornerRadius = 6
        button.setTitle("이 커버 선택", for: .normal)
        button.titleLabel?.font = .buttonText
        self.view.addSubview(button)
        return button
    }()
    
    // MARK: - Property
    private let viewModel: AlbumCoverViewModel
    private let disposeBag = DisposeBag()
    
    // MARK: - Init
    init(viewModel: AlbumCoverViewModel) {
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
        view.backgroundColor = .black
        
        topBar.snp.makeConstraints {
            $0.top.left.right.equalTo(view.safeAreaLayoutGuide)
            $0.height.equalTo(52 * layoutScale)
        }
        
        titleLabel.snp.makeConstraints {
            $0.height.equalTo(24 * layoutScale)
            $0.center.equalToSuperview()
        }
        
        closeButton.snp.makeConstraints {
            $0.width.height.equalTo(34 * layoutScale)
            $0.right.equalToSuperview().offset(-9 * layoutScale)
            $0.centerY.equalToSuperview()
        }
        
        descriptionLabel.snp.makeConstraints {
            $0.height.equalTo(46 * layoutScale)
            $0.top.equalTo(topBar.snp.bottom).offset(29 * layoutScale)
            $0.left.equalToSuperview().offset(18 * layoutScale)
            $0.right.equalToSuperview().offset(-18 * layoutScale)
        }
        
        coverImageView.snp.makeConstraints {
            $0.width.height.equalTo(199 * layoutScale)
            $0.width.equalTo(coverImageView.snp.height)
            $0.top.equalTo(descriptionLabel.snp.bottom).offset(53 * layoutScale)
            $0.centerXWithinMargins.equalToSuperview()
        }
        
        collectionView.snp.makeConstraints {
            $0.height.equalTo(118 * layoutScale)
            $0.top.lessThanOrEqualTo(coverImageView.snp.bottom).offset(51 * layoutScale)
            $0.left.right.equalToSuperview()
        }
        
        button.snp.makeConstraints {
            $0.height.equalTo(57 * layoutScale)
            $0.top.equalTo(collectionView.snp.bottom).offset(21 * layoutScale)
            $0.bottom.lessThanOrEqualTo(view.safeAreaLayoutGuide.snp.bottom).offset(-21 * layoutScale)
            $0.left.equalToSuperview().offset(18 * layoutScale)
            $0.right.equalToSuperview().offset(-18 * layoutScale)
        }
    }
    
    typealias CoverSectionModel = SectionModel<String, CoverImageCellViewModel>
    typealias CoverDataSource = RxCollectionViewSectionedReloadDataSource<CoverSectionModel>
    
    private func bindState() {
        let dataSource = CoverDataSource(configureCell: { (datasource, collectionView, indexPath, item) in
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: CoverImageCell.identifier, for: indexPath) as! CoverImageCell
            cell.bind(viewModel: item)
            return cell
        })
        
        viewModel.output.coverSection
            .bind(to: collectionView.rx.items(dataSource: dataSource))
            .disposed(by: disposeBag)
        
        viewModel.output.selectedCover
            .map { $0.image }
            .bind(to: coverImageView.rx.image)
            .disposed(by: disposeBag)

        viewModel.output.next
            .subscribe { _ in
                self.createAlbum()
            }
            .disposed(by: disposeBag)
        
        viewModel.output.close
            .bind { _ in
                self.close()
            }
            .disposed(by: disposeBag)
    }
    
    private func bindAction() {
        collectionView.rx
            .itemSelected
            .bind(to: viewModel.input.selectCover)
            .disposed(by: disposeBag)
        
        button.rx.tap
            .bind(to: viewModel.input.next)
            .disposed(by: disposeBag)
        
        closeButton.rx.tap
            .bind(to: viewModel.input.close)
            .disposed(by: disposeBag)
        
        viewModel.input.selectCover.accept(.init(item: 0, section: 0))
    }
    
    private func createAlbum() {
        let vc = AlbumNameViewController(viewModel: viewModel.viewModelForCreateNameAlbum())
        DispatchQueue.main.async {
            self.navigationController?.pushViewController(vc, animated: true)
        }
    }
    
    private func close() {
        DispatchQueue.main.async {
            self.dismiss(animated: true)
        }
    }
}
