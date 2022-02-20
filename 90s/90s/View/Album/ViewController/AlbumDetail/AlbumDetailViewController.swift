//
//  AlbumViewController.swift
//  90s
//
//  Created by 김진우 on 2021/12/01.
//

import UIKit
import RxSwift
import RxCocoa
import SnapKit
import RxDataSources


class AlbumDetailViewController: UIViewController {
    
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
//        layout.sectionInset = .init(top: 0, left: 0, bottom: 0, right: 0)
        layout.minimumLineSpacing = 0
        layout.minimumInteritemSpacing = 0
        layout.scrollDirection = .horizontal
        let width = UIScreen.main.bounds.width
        let height = width * 1.662538
        layout.itemSize = .init(width: width, height: height)
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
        collectionView.isPagingEnabled = true
        collectionView.register(TemplateCell.self, forCellWithReuseIdentifier: TemplateCell.identifier)
        collectionView.translatesAutoresizingMaskIntoConstraints = false
        
        view.addSubview(collectionView)
        
        return collectionView
    }()
    
    private lazy var contorlBar: AlbumControlBar = {
        let controlBar = AlbumControlBar()
//        contorlBar.delegate = self
        view.addSubview(controlBar)
        return controlBar
    }()
    
    // MARK: - Property
    private let viewModel: AlbumDetailViewModel
    private let disposeBag = DisposeBag()
    
    init(viewModel: AlbumDetailViewModel) {
        self.viewModel = viewModel
        
        super.init(nibName: nil, bundle: nil)
        
        setupUI()
        bindState()
        bindAction()
    }
    
    // MARK: - Init
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
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

        closeButton.snp.makeConstraints {
            $0.width.height.equalTo(34 * layoutScale)
            $0.trailing.equalToSuperview().offset(-9 * layoutScale)
            $0.centerY.equalToSuperview()
        }
        
        collectionView.snp.makeConstraints {
            $0.height.equalTo(collectionView.snp.width).multipliedBy(1.662538)
            $0.top.lessThanOrEqualTo(topBar.snp.bottom)
            $0.leading.trailing.equalToSuperview()
            $0.bottom.lessThanOrEqualTo(view.safeAreaLayoutGuide.snp.bottom)
        }
        
        contorlBar.snp.makeConstraints {
            $0.height.equalTo(84 * layoutScale)
            $0.leading.trailing.equalToSuperview()
            $0.bottom.equalTo(view.safeAreaLayoutGuide.snp.bottom)
        }
    }
    
    private func bindState() {
        viewModel.output.title
            .bind(to: titleLabel.rx.text)
            .disposed(by: disposeBag)
        
        let dataSource = TemplateDataSource(configureCell: { (dataSource, collectionView, indexPath, item) in
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: TemplateCell.identifier, for: indexPath) as! TemplateCell
            cell.bind(viewModel: item)
            cell.delegate = self
            return cell
        })
        
        viewModel.output.pageSection
            .bind(to: collectionView.rx.items(dataSource: dataSource))
            .disposed(by: disposeBag)
        
        viewModel.output.back
            .bind { _ in
                DispatchQueue.main.async {
                    self.dismiss(animated: true, completion: nil)
                }
            }
            .disposed(by: disposeBag)
        
        viewModel.output.close
            .bind { _ in
                DispatchQueue.main.async {
                    self.dismiss(animated: true, completion: nil)
                }
            }
            .disposed(by: disposeBag)
        
        viewModel.output.controlBarIsHidden
            .bind(to: contorlBar.rx.isHidden)
            .disposed(by: disposeBag)
        
        viewModel.output.dismiss
            .bind { _ in
                DispatchQueue.main.async {
                    self.dismiss(animated: true, completion: nil)
                }
            }
            .disposed(by: disposeBag)
        
        collectionView.allowsSelection = viewModel.dependency.isEditing
    }
    
    private func bindAction() {
        backButton.rx.tap
            .bind(to: viewModel.input.back)
            .disposed(by: disposeBag)
        
        closeButton.rx.tap
            .bind(to: viewModel.input.close)
            .disposed(by: disposeBag)
        
        collectionView.rx.itemSelected
            .map { _ in () }
            .bind(to: viewModel.input.controlBarToggle)
            .disposed(by: disposeBag)
        
        contorlBar.delegate = self
    }
}

extension AlbumDetailViewController: TemplateCellDelegate {
    func didTapPhoto(page: Int, index: Int) {
        print("Page: \(page), Index: \(index)")
    }
}

/*
extension AlbumDetailViewController: PhotoPickerDelegate {
 func didSelected(photoUID: Int, page: Int, index:Int) {
    AlbumRepository.shared.updatePhoto(at: viewModel.dependency.albumViewModel.id, page: page, index: index, photoUID: photoUID)
}
*/

extension AlbumDetailViewController: AlbumControlBarDelegate {
    func didSelectListView() {
        let vc = AlbumDetailCollectionViewController(viewModel: .init(dependency: .init(albumViewModel: viewModel.dependency.albumViewModel)))
        DispatchQueue.main.async {
            self.navigationController?.pushViewController(vc, animated: true)
        }
    }
    func completeButtonAction() {
        viewModel.input.complete.accept(())
    }
}
