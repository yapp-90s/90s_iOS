//
//  AlbumSelectPhotoViewController.swift
//  90s
//
//  Created by 성다연 on 2021/10/16.
//

import UIKit
import RxSwift
import SnapKit
import RxCocoa

final class AlbumSelectPhotoViewController: BaseViewController {
    private let printedPhotoButton : UIButton = {
        let button = UIButton(frame: .zero)
        button.setTitle("인화한 사진", for: .normal)
        button.setTitleColor(.white, for: .normal)
        
        return button
    }()
    
    private let printedFilmButton : UIButton = {
        let button = UIButton(frame: .zero)
        button.setTitle("인화한 필름", for: .normal)
        button.setTitleColor(.white, for: .normal)
        
        return button
    }()
    
    private let photoCollectionView : UICollectionView = {
        let cv = UICollectionView(frame: .zero, collectionViewLayout: .init())
        cv.showsVerticalScrollIndicator = false
        
        cv.register(PinterestCollectionViewCell.self, forCellWithReuseIdentifier: PinterestCollectionViewCell.cellID)
        return cv
    }()
    
    private let filmTableView : UITableView = {
        let tv = UITableView(frame: .zero, style: .grouped)
        tv.showsVerticalScrollIndicator = false
        tv.separatorStyle = .none
        tv.isHidden = true
        tv.backgroundColor = .lightGray
        
        tv.register(FilmInfoTableViewCell.self, forCellReuseIdentifier: FilmInfoTableViewCell.cellId)
        return tv
    }()
    
    // MARK: - Property
    
    private var photoViewModel = FilmsViewModel(dependency: .init())
    private var filmViewModel = FilmListViewModel(dependency: .init())
    
    // MARK: - LifeCycle
    
    init() {
        super.init(nibName: nil, bundle: nil)
    }

    init(photoViewModel : FilmsViewModel, filmViewModel: FilmListViewModel) {
        self.photoViewModel = photoViewModel
        self.filmViewModel = filmViewModel
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setUpNavigatorBar()
        setUpSubviews()
        setUpCollectionViewDataSource()
        setUpTableViewViewDataSource()
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
        view.addSubview(photoCollectionView)
        view.addSubview(filmTableView)
        
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
        
        photoCollectionView.snp.makeConstraints {
            $0.top.equalTo(view.safeAreaLayoutGuide.snp.top).offset(50)
            $0.left.right.bottom.equalTo(view.safeAreaLayoutGuide)
        }

        filmTableView.snp.makeConstraints {
            $0.top.equalTo(view.safeAreaLayoutGuide.snp.top).offset(50)
            $0.left.right.bottom.equalTo(view.safeAreaLayoutGuide)
        }
    }
    
    @objc private func handleNavigationRightButton() {
        navigationController?.dismiss(animated: true)
    }
}

// MARK: select photo
extension AlbumSelectPhotoViewController : UICollectionViewDelegateFlowLayout, PinterestLayoutDelegate {
    private func setUpCollectionViewDataSource(){
        let layout = PinterestLayout()
        layout.delegate = self
        
        photoCollectionView.rx.setDelegate(self).disposed(by: disposeBag)
        
        photoCollectionView.collectionViewLayout = layout
        
        photoViewModel.output.photos
            .bind(to: photoCollectionView.rx.items(cellIdentifier: PinterestCollectionViewCell.cellID, cellType: PinterestCollectionViewCell.self)) { index, element, cell in
                cell.bindViewModel(image: element.url)
            }
            .disposed(by: disposeBag)
      
        photoCollectionView.rx.modelSelected(Photo.self)
            .subscribe(onNext: { photo in
                let selectedPhoto = DecorateContainerViewModel(dependency: .init(selectedPhoto: photo))
                let nextVC = DecorateContainerViewController(selectedPhoto)
                self.navigationController?.pushViewController(nextVC, animated: true)
            })
            .disposed(by: disposeBag)
    }
    
    func collectionView(_ collectionView: UICollectionView, heightForPhotoAtIndexPath indexPath: IndexPath) -> CGFloat {
        let index = photoViewModel.output.photos.value[indexPath.row]
        
        return index.height
    }
}

// MARK: select film
extension AlbumSelectPhotoViewController {
    private func setUpTableViewViewDataSource() {
        filmTableView.rx.setDelegate(self).disposed(by: disposeBag)
        
        filmViewModel.output.film_complete
            .bind(to: filmTableView.rx.items(cellIdentifier: FilmInfoTableViewCell.cellId, cellType: FilmInfoTableViewCell.self)) {
                index, element, cell in
                cell.showStateImage(show: false)
                cell.isEditStarted(value: false)
                cell.isEditCellSelected(value: false)
                cell.bindViewModel(film: element, isCreate: false)
                cell.selectionStyle = .none
            }
            .disposed(by: disposeBag)
        
        filmTableView.rx.modelSelected(Film.self)
            .subscribe(onNext: { [weak self] item in
                let nextVC = AlbumSelectPhotoByFilmViewController(film: item)
                self?.navigationController?.pushViewController(nextVC, animated: true)
            })
            .disposed(by: disposeBag)
    }
}
