//
//  AlbumSelectPhotoViewController.swift
//  90s
//
//  Created by 성다연 on 2021/10/16.
//

import UIKit
import RxSwift
import SnapKit

final class AlbumSelectPhotoViewController: BaseViewController {
    private let printedPhotoButton : UIButton = {
        let button = UIButton(frame: .zero)
        button.titleLabel?.text = "인화한 사진"
        button.setTitleColor(.white, for: .normal)
        return button
    }()
    
    private let printedFilmButton : UIButton = {
        let button = UIButton(frame: .zero)
        button.titleLabel?.text = "인화한 필름"
        button.setTitleColor(.white, for: .normal)
        return button
    }()
    
    private let collectionView : UICollectionView = {
        let cv = UICollectionView(frame: .zero, collectionViewLayout: .init())
        return cv
    }()
    
    // MARK: - Property
    
    private var viewModel = FilmListViewModel(dependency: .init())
    
    
    // MARK: - LifeCycle
    
    init(viewModel: FilmListViewModel) {
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setUpNavigatorBar()
        setUpSubviews()
    }
    
    // MARK: - Methods
    
    private func setUpNavigatorBar() {
        setBarButtonItem(type: .imgClose, position: .right, action: #selector(handleNavigationRightButton))
        tabBarController?.tabBar.isHidden = true
        navigationItem.title = "사진 선택"
    }
    
    private func setUpSubviews() {
        view.addSubview(printedFilmButton)
        view.addSubview(printedPhotoButton)
        view.addSubview(collectionView)
        
        printedPhotoButton.snp.makeConstraints {
            $0.height.equalTo(50)
            $0.width.equalTo(view.frame.width / 2)
            $0.left.equalTo(view.safeAreaLayoutGuide.snp.left)
            $0.top.equalTo(view.safeAreaLayoutGuide.snp.top)
        }
        
        printedFilmButton.snp.makeConstraints {
            $0.height.equalTo(50)
            $0.width.equalTo(view.frame.width / 2)
            $0.right.equalTo(view.safeAreaLayoutGuide.snp.right)
            $0.top.equalTo(view.safeAreaLayoutGuide.snp.top)
        }
        
        collectionView.snp.makeConstraints {
            $0.top.equalTo(view.safeAreaLayoutGuide.snp.top).offset(50)
            $0.left.right.bottom.equalTo(view.safeAreaLayoutGuide)
        }
    }
    
    @objc private func handleNavigationRightButton() {
        navigationController?.dismiss(animated: true)
    }
}


extension AlbumSelectPhotoViewController : UICollectionViewDelegateFlowLayout {
    
}
