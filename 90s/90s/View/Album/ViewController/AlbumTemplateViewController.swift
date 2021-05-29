//
//  AlbumTemplateViewController.swift
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
    
    private let TEMPLATE_HEIGHT_SCALE: CGFloat = 1.662538
    
    private lazy var tagLabel: UILabel = {
        let label = UILabel()
        self.view.addSubview(label)
        return label
    }()
    
    private lazy var titleLabel: UILabel = {
        let label = UILabel()
        label.textColor = .white
        self.view.addSubview(label)
        return label
    }()
    
    private lazy var button: UIButton = {
        let button = UIButton()
        button.setTitle("결정하기", for: .normal)
        button.setTitleColor(.white, for: .normal)
        button.backgroundColor = .retroOrange
        button.layer.cornerRadius = 6
        self.view.addSubview(button)
        return button
    }()
    
    private lazy var collectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.sectionInset = .init(top: 20, left: 26, bottom: 20, right: 26)
        layout.minimumInteritemSpacing = 0
        layout.minimumLineSpacing = 12
        let width = UIScreen.main.bounds.width - 52
        layout.itemSize = .init(width: width, height: width * TEMPLATE_HEIGHT_SCALE)
        layout.scrollDirection = .horizontal
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
        collectionView.register(TemplateDetailCollectionViewCell.self, forCellWithReuseIdentifier: TemplateDetailCollectionViewCell.identifier)
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
        tagLabel.snp.makeConstraints {
            $0.width.equalTo(37)
            $0.height.equalTo(18)
            $0.top.equalTo(view.safeAreaLayoutGuide.snp.top).offset(21)
            $0.left.equalToSuperview().offset(18)
        }
        
        titleLabel.snp.makeConstraints {
            $0.height.equalTo(24)
            $0.top.equalTo(tagLabel.snp.bottom).offset(7)
            $0.left.equalTo(18)
        }
        
        button.snp.makeConstraints {
            $0.width.equalTo(103)
            $0.height.equalTo(48)
            $0.top.equalTo(view.safeAreaLayoutGuide.snp.top).offset(21)
            $0.left.equalTo(titleLabel.snp.right).offset(18)
            $0.right.equalToSuperview().offset(-18)
        }
        
        collectionView.snp.makeConstraints {
            $0.top.equalTo(titleLabel.snp.bottom).offset(40)
            $0.left.right.equalToSuperview()
            $0.bottom.equalTo(view.safeAreaLayoutGuide.snp.bottom)
        }
    }
    
    typealias TemplateSectionModel = SectionModel<String, TemplateViewModel>
    typealias TemplateDataSource = RxCollectionViewSectionedReloadDataSource<TemplateSectionModel>
    
    private func bindViewModel() {
        let dataSource = TemplateDataSource(configureCell: { (_, collectionView, indexPath, item) in
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: TemplateDetailCollectionViewCell.identifier, for: indexPath) as! TemplateDetailCollectionViewCell
            cell.bind(viewModel: self.viewModel.selectedTemplateRelay.value)
            return cell
        })
        
        viewModel.templateSection
            .bind(to: collectionView.rx.items(dataSource: dataSource))
            .disposed(by: disposeBag)
        
        viewModel.selectedTemplateRelay.value
            .name
            .bind(to: titleLabel.rx.text)
            .disposed(by: disposeBag)
        
        button.rx.tap
            .bind(to: viewModel.next)
            .disposed(by: disposeBag)
        
        viewModel.next
            .subscribe { _ in
                self.createAlbum()
            }.disposed(by: disposeBag)
        
    }
    
    private func createAlbum() {
        let vc = AlbumCreatePreviewViewController(viewModel: viewModel)
        DispatchQueue.main.async {
            self.navigationController?.pushViewController(vc, animated: false)
        }
    }
}
