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

final class AlbumTemplatePreviewViewController: UIViewController {
    
    private let TEMPLATE_HEIGHT_SCALE: CGFloat = 1.662538
    
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
    
    private lazy var descriptionLabel: UILabel = {
        let label = UILabel()
        label.font = .largeTextBold
        label.textColor = .white
        self.view.addSubview(label)
        return label
    }()
    
    private lazy var tagLabel: UILabel = {
        let label = UILabel()
        self.view.addSubview(label)
        return label
    }()
    
    private lazy var button: UIButton = {
        let button = UIButton()
        button.setTitle("결정하기", for: .normal)
        button.titleLabel?.font = .buttonText
        button.setTitleColor(.white, for: .normal)
        button.backgroundColor = .retroOrange
        button.layer.cornerRadius = 6
        self.view.addSubview(button)
        return button
    }()
    
    private lazy var collectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.sectionInset = .init(top: 20 * layoutScale, left: 26 * layoutScale, bottom: 20 * layoutScale, right: 26 * layoutScale)
        layout.minimumInteritemSpacing = 0
        layout.minimumLineSpacing = 12 * layoutScale
        let width = UIScreen.main.bounds.width - 52 * layoutScale
        layout.itemSize = .init(width: width, height: width * TEMPLATE_HEIGHT_SCALE)
        layout.scrollDirection = .horizontal
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
        collectionView.register(TemplateDetailCollectionViewCell.self, forCellWithReuseIdentifier: TemplateDetailCollectionViewCell.identifier)
        collectionView.delegate = self
        self.view.addSubview(collectionView)
        return collectionView
    }()
    
    private var currentIndex: CGFloat = 0
    private let viewModel: AlbumTemplatePreviewViewModel
    private let disposeBag = DisposeBag()
    
    init(viewModel: AlbumTemplatePreviewViewModel) {
        self.viewModel = viewModel
        
        super.init(nibName: nil, bundle: nil)
        
        setupUI()
        bindState()
        bindAction()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        
        let layout = collectionView.collectionViewLayout as! UICollectionViewFlowLayout
        let cellWidth = layout.itemSize.width + layout.minimumLineSpacing
        let x: Double = Double(viewModel.dependency.albumCreate.selectedIndex) * cellWidth
        collectionView.scrollRectToVisible(.init(x: x, y: 0, width: collectionView.visibleSize.width, height: collectionView.visibleSize.height), animated: true)
        currentIndex = CGFloat(viewModel.dependency.albumCreate.selectedIndex)
    }
    
    private func setupUI() {
        view.backgroundColor = .black
        
        topBar.snp.makeConstraints {
            $0.top.left.right.equalTo(view.safeAreaLayoutGuide)
            $0.height.equalTo(52 * layoutScale)
        }
        
        backButton.snp.makeConstraints {
            $0.width.height.equalTo(34 * layoutScale)
            $0.left.equalToSuperview().offset(9 * layoutScale)
            $0.centerY.equalToSuperview()
        }
        
        tagLabel.snp.makeConstraints {
            $0.width.equalTo(37 * layoutScale)
            $0.height.equalTo(18 * layoutScale)
            $0.top.equalTo(topBar.snp.bottom).offset(10 * layoutScale)
            $0.left.equalToSuperview().offset(18 * layoutScale)
        }
        
        descriptionLabel.snp.makeConstraints {
            $0.height.equalTo(24 * layoutScale)
            $0.top.equalTo(tagLabel.snp.bottom).offset(5 * layoutScale)
            $0.left.equalTo(18 * layoutScale)
        }
        
        button.snp.makeConstraints {
            $0.width.equalTo(103 * layoutScale)
            $0.height.equalTo(48 * layoutScale)
            $0.top.equalTo(topBar.snp.bottom).offset(21 * layoutScale)
            $0.left.equalTo(descriptionLabel.snp.right).offset(18 * layoutScale)
            $0.right.equalToSuperview().offset(-18 * layoutScale)
        }
        
        collectionView.snp.makeConstraints {
            $0.top.equalTo(descriptionLabel.snp.bottom).offset(33 * layoutScale)
            $0.left.right.equalToSuperview()
            $0.bottom.equalTo(view.safeAreaLayoutGuide.snp.bottom)
        }
    }
    
    typealias TemplateSectionModel = SectionModel<String, TemplateViewModel>
    typealias TemplateDataSource = RxCollectionViewSectionedReloadDataSource<TemplateSectionModel>
    
    private func bindState() {
        let dataSource = TemplateDataSource(configureCell: { (_, collectionView, indexPath, item) in
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: TemplateDetailCollectionViewCell.identifier, for: indexPath) as! TemplateDetailCollectionViewCell
            cell.bind(viewModel: item)
            return cell
        })
        
        viewModel.output.templateSection
            .bind(to: collectionView.rx.items(dataSource: dataSource))
            .disposed(by: disposeBag)
        
        viewModel.output.albumCreate.name
            .bind(to: descriptionLabel.rx.text)
            .disposed(by: disposeBag)
        
        viewModel.output.next
            .subscribe { [weak self] _ in
                self?.createAlbum()
            }
            .disposed(by: disposeBag)
    }
    
    private func bindAction() {
        button.rx.tap
            .subscribe(onNext: { [weak self] _ in
                self?.createAlbum()
            })
            .disposed(by: disposeBag)
        
        backButton.rx.tap
            .subscribe(onNext: { [weak self] _ in
                self?.navigationController?.popViewController(animated: true)
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
        let vm = viewModel.viewModelForAlbumCreatePreviewViewModel()
        let vc = AlbumCompleteViewController(viewModel: vm)
        DispatchQueue.main.async {
            self.navigationController?.pushViewController(vc, animated: true)
        }
    }
}

extension AlbumTemplatePreviewViewController: UICollectionViewDelegate {
    func scrollViewWillEndDragging(_ scrollView: UIScrollView, withVelocity velocity: CGPoint, targetContentOffset: UnsafeMutablePointer<CGPoint>) {
        if let cv = scrollView as? UICollectionView {
            let layout = cv.collectionViewLayout as! UICollectionViewFlowLayout
            let cellWidth = layout.itemSize.width + layout.minimumLineSpacing
            
            var offset = targetContentOffset.pointee
            let idx = round((offset.x + cv.contentInset.left) / cellWidth)
            
            if idx > currentIndex {
                currentIndex += 1
            } else if idx < currentIndex {
                if currentIndex != 0 {
                    currentIndex -= 1
                }
            }
            Observable.just(IndexPath(item: Int(currentIndex), section: 0))
                .bind(to: viewModel.input.selectTemplate)
                .disposed(by: disposeBag)
            
            offset = CGPoint(x: currentIndex * cellWidth - cv.contentInset.left, y: 0)
            
            targetContentOffset.pointee = offset
        }
    }
}
