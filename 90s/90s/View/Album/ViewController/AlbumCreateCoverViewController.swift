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

class AlbumCreateCoverViewController: UIViewController {
    
    // MARK: - UI Component
    private lazy var collectionViewLayout: UICollectionViewLayout = {
        let layout = UICollectionViewCompositionalLayout { (sectionIndex, environment) -> NSCollectionLayoutSection? in
            let itemSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1), heightDimension: .fractionalHeight(1))
            let item = NSCollectionLayoutItem(layoutSize: itemSize)
            
            let groupSize = NSCollectionLayoutSize(widthDimension: .absolute(118), heightDimension: .absolute(118))
            let group = NSCollectionLayoutGroup.vertical(layoutSize: groupSize, subitems: [item])
            
            let section = NSCollectionLayoutSection(group: group)
            section.orthogonalScrollingBehavior = .continuous
            section.interGroupSpacing = .init(16)
            
            return section
        }
        return layout
    }()
    
    private lazy var titleLabel: UILabel = {
        let label = UILabel()
        label.numberOfLines = 2
        label.text = "앨범의 얼굴,\n커버를 선택해 주세요"
        self.view.addSubview(label)
        return label
    }()
    
    private lazy var coverImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.backgroundColor = .green
        self.view.addSubview(imageView)
        return imageView
    }()
    
    private lazy var collectionView: UICollectionView = {
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: collectionViewLayout)
        
        collectionView.register(CoverCollectionViewCell.self, forCellWithReuseIdentifier: CoverCollectionViewCell.identifier)
        collectionView.translatesAutoresizingMaskIntoConstraints = false
        
        self.view.addSubview(collectionView)
        
        return collectionView
    }()
    
    private lazy var button: UIButton = {
        let button = UIButton()
        button.backgroundColor = .retroOrange
        button.layer.cornerRadius = 6
        button.setTitle("이 커버 선택", for: .normal)
        self.view.addSubview(button)
        return button
    }()
    
    // MARK: - Property
    private let viewModel: AlbumCreateViewModel
    private let disposeBag = DisposeBag()
    
    // MARK: - Init
    init(viewModel: AlbumCreateViewModel) {
        self.viewModel = viewModel
        
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - LifeCycle
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupUI()
        bindViewModel()
        bindCollectionView()
    }
    
    private func setupUI() {
        view.backgroundColor = .black
        
        titleLabel.snp.makeConstraints {
            $0.height.equalTo(46)
            $0.top.equalTo(view.safeAreaLayoutGuide.snp.top).offset(29)
            $0.left.equalToSuperview().offset(18)
            $0.right.equalToSuperview().offset(-18)
        }
        
        coverImageView.snp.makeConstraints {
            $0.width.height.equalTo(199)
            $0.width.equalTo(coverImageView.snp.height)
            $0.top.equalTo(titleLabel.snp.bottom).offset(53)
            $0.centerXWithinMargins.equalToSuperview()
        }
        
        collectionView.snp.makeConstraints {
            $0.height.equalTo(118)
            $0.top.equalTo(coverImageView.snp.bottom).offset(51)
            $0.left.right.equalToSuperview()
        }
        
        button.snp.makeConstraints {
            $0.height.equalTo(57)
            $0.top.equalTo(collectionView.snp.bottom).offset(21)
            $0.bottom.lessThanOrEqualTo(view.safeAreaLayoutGuide.snp.bottom).offset(-21)
            $0.left.equalToSuperview().offset(18)
            $0.right.equalToSuperview().offset(-18)
        }
    }
    
    typealias CoverSectionModel = SectionModel<String, CoverViewModel>
    typealias CoverDataSource = RxCollectionViewSectionedReloadDataSource<CoverSectionModel>
    
    private func bindCollectionView() {
        let dataSource = CoverDataSource(configureCell: { (datasource, collectionView, indexPath, item) in
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: CoverCollectionViewCell.identifier, for: indexPath) as! CoverCollectionViewCell
            cell.bind(viewModel: item)
            return cell
        })
        
        viewModel.coverSection
            .bind(to: collectionView.rx.items(dataSource: dataSource))
            .disposed(by: disposeBag)
    }
    
    private func bindViewModel() {
        
        viewModel.selectedCover
            .map { $0.image }
            .asDriver()
            .drive(coverImageView.rx.image)
            .disposed(by: disposeBag)
        
        viewModel.next
            .subscribe { _ in
                self.createAlbum()
            }.disposed(by: disposeBag)
        
        collectionView.rx
            .itemSelected
            .map { self.viewModel.coverSection.value.first!.items[$0.item].cover.value }
            .bind(to: viewModel.selectCover)
            .disposed(by: disposeBag)
        
        button.rx.tap
            .bind(to: viewModel.next)
            .disposed(by: disposeBag)
    }
    
    private func createAlbum() {
        let vc = AlbumCreateNameViewController(viewModel: viewModel)
        DispatchQueue.main.async {
            self.navigationController?.pushViewController(vc, animated: false)
        }
    }
}
