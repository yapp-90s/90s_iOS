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

final class AlbumTemplateViewController: UIViewController {
    
    let SCREEN_WIDTH: CGFloat = UIScreen.main.bounds.width
    
    private lazy var topBar: UIView = {
        let view = UIView()
        self.view.addSubview(view)
        return view
    }()

    private lazy var titleLabel: UILabel = {
        let label = UILabel()
        topBar.addSubview(label)
        label.text = "앨범 만들기(3/3)"
        label.font = .Sub_Head
        return label
    }()

    private lazy var backButton: UIButton = {
        let button = UIButton()
        button.setImage(.init(named: "navigationBar_back"), for: .normal)
        topBar.addSubview(button)
        return button
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
        label.font = .Sub_Head
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
    
    private let viewModel: AlbumTemplateViewModel
    private let disposeBag = DisposeBag()
    
    init(viewModel: AlbumTemplateViewModel) {
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
        
        backButton.snp.makeConstraints {
            $0.width.height.equalTo(34 * layoutScale)
            $0.left.equalToSuperview().offset(9 * layoutScale)
            $0.centerY.equalToSuperview()
        }
        
        closeButton.snp.makeConstraints {
            $0.width.height.equalTo(34 * layoutScale)
            $0.right.equalToSuperview().offset(-9 * layoutScale)
            $0.centerY.equalToSuperview()
        }
        
        descriptionLabel.snp.makeConstraints {
            $0.top.equalTo(topBar.snp.bottom).offset(29 * layoutScale)
            $0.left.equalToSuperview().offset(18 * layoutScale)
        }
        
        coverImageView.snp.makeConstraints {
            $0.width.height.equalTo(44 * layoutScale)
            $0.top.equalTo(topBar.snp.bottom).offset(30 * layoutScale)
            $0.right.equalToSuperview().offset(-17 * layoutScale)
            $0.left.equalTo(descriptionLabel.snp.right).offset(18 * layoutScale)
        }
        
        collectionView.snp.makeConstraints {
            $0.top.equalTo(descriptionLabel.snp.bottom).offset(29 * layoutScale)
            $0.left.right.equalToSuperview()
            $0.bottom.equalTo(view.safeAreaLayoutGuide.snp.bottom)
        }
        
    }
    typealias TemplateSectionModel = SectionModel<String, TemplateViewModel>
    typealias TemplateDataSource = RxCollectionViewSectionedReloadDataSource<TemplateSectionModel>
    
    private func bindState() {
        let dataSource = TemplateDataSource(configureCell: { (datasource, collectionView, indexPath, item) in
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: TemplateCollectionViewCell.identifier, for: indexPath) as! TemplateCollectionViewCell
            cell.bind(viewModel: item)
            return cell
        })
        
        viewModel.output.templateSection
            .bind(to: collectionView.rx.items(dataSource: dataSource))
            .disposed(by: disposeBag)
        
        viewModel.output.albumCreate.cover
            .map { $0.image }
            .bind(to: coverImageView.rx.image)
            .disposed(by: disposeBag)
        
        viewModel.output.next
            .subscribe({ _ in
                self.createAlbum()
            }).disposed(by: disposeBag)
    }
    
    private func bindAction() {
        collectionView.rx.itemSelected
            .bind(to: viewModel.input.selectTemplate)
            .disposed(by: disposeBag)
        
        backButton.rx.tap
            .subscribe(onNext: { _ in
                self.back()
            })
            .disposed(by: disposeBag)
        
        closeButton.rx.tap
            .subscribe(onNext: { _ in
                self.dismiss()
            })
            .disposed(by: disposeBag)
    }
    
    private func back() {
        DispatchQueue.main.async {
            self.navigationController?.popViewController(animated: true)
        }
    }
    
    private func dismiss() {
        DispatchQueue.main.async {
            self.dismiss(animated: true, completion: nil)
        }
    }
    
    private func createAlbum() {
        let vc = AlbumTemplatePreviewViewController(viewModel: self.viewModel.viewModelForeCreateTemplatePreview())
        DispatchQueue.main.async {
            self.navigationController?.pushViewController(vc, animated: true)
        }
    }
}
