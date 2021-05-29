//
//  AlbumCreateTemplateViewController.swift
//  90s
//
//  Created by 김진우 on 2021/04/10.
//

import UIKit
import RxSwift
import RxCocoa
import SnapKit
import RxDataSources

final class AlbumCreateTemplateViewController: UIViewController {
    
    let SCREEN_WIDTH: CGFloat = UIScreen.main.bounds.width
    
    private lazy var titleLabel: UILabel = {
        let label = UILabel()
        label.numberOfLines = 2
        label.text = "이 앨범은 어떤 앨범인가요?\n이름을 정해주세요:)"
        self.view.addSubview(label)
        return label
    }()
    
    private lazy var coverImageView: UIImageView = {
        let imageView = UIImageView()
        self.view.addSubview(imageView)
        return imageView
    }()
    
    private lazy var collectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        let cellWidth = (SCREEN_WIDTH - 47) / 2
        let cellHeight = cellWidth * 1.664634 + 30
        layout.itemSize = .init(width: cellWidth, height: cellHeight)
        layout.sectionInset = .init(top: 24, left: 18, bottom: 24, right: 18)
        layout.minimumLineSpacing = 18
        layout.minimumInteritemSpacing = 11
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
        collectionView.register(TemplateCollectionViewCell.self, forCellWithReuseIdentifier: TemplateCollectionViewCell.identifier)
        collectionView.showsVerticalScrollIndicator = false
        self.view.addSubview(collectionView)
        return collectionView
    }()
    
    private let viewModel: AlbumCreateViewModel
    private let disposeBag = DisposeBag()
    
    init(viewModel: AlbumCreateViewModel) {
        self.viewModel = viewModel
        
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupUI()
        bindViewModel()
    }
    
    private func setupUI() {
        view.backgroundColor = .black
        titleLabel.snp.makeConstraints {
            $0.top.equalTo(view.safeAreaLayoutGuide.snp.top).offset(29)
            $0.left.equalToSuperview().offset(18)
        }
        
        coverImageView.snp.makeConstraints {
            $0.width.height.equalTo(44)
            $0.top.equalTo(view.safeAreaLayoutGuide.snp.top).offset(30)
            $0.right.equalToSuperview().offset(-17)
            $0.left.equalTo(titleLabel.snp.right).offset(18)
        }
        
        collectionView.snp.makeConstraints {
            $0.top.equalTo(titleLabel.snp.bottom).offset(29)
            $0.left.right.equalToSuperview()
            $0.bottom.equalTo(view.safeAreaLayoutGuide.snp.bottom)
        }
        
    }
    typealias TemplateSectionModel = SectionModel<String, TemplateViewModel>
    typealias TemplateDataSource = RxCollectionViewSectionedReloadDataSource<TemplateSectionModel>
    
    private func bindViewModel() {
        
        let dataSource = TemplateDataSource(configureCell: { (datasource, collectionView, indexPath, item) in
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: TemplateCollectionViewCell.identifier, for: indexPath) as! TemplateCollectionViewCell
            cell.bind(viewModel: item)
            return cell
        })
        
        viewModel.templateSection
            .bind(to: collectionView.rx.items(dataSource: dataSource))
            .disposed(by: disposeBag)
        
        viewModel.selectedCover
            .map { $0.image }
            .asDriver()
            .drive(coverImageView.rx.image)
            .disposed(by: disposeBag)
        
        collectionView.rx.itemSelected
            .map { self.viewModel.templateSection.value.first!.items[$0.item] }
            .bind(to: viewModel.selectTempalte)
            .disposed(by: disposeBag)
        
        viewModel.selectedTemplate
            .subscribe({ _ in
                self.createAlbum()
            }).disposed(by: disposeBag)
    }
    
    private func createAlbum() {
        let vc = AlbumTemplateViewController(viewModel: self.viewModel)
        DispatchQueue.main.async {
            self.navigationController?.pushViewController(vc, animated: false)
        }
    }
}
