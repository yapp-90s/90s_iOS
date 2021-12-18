
//
//  FilmGalleryViewController.swift
//  90s
//
//  Created by 성다연 on 2021/11/08.
//

import UIKit
import SnapKit
import Photos
import RxSwift

// TODO: - 할 일 : ViewModel 생성, 이미지 분할 -> Rx 바인딩

final class FilmGalleryViewController: BaseViewController, UIScrollViewDelegate {
    private let collectionView : UICollectionView = {
        let cv = UICollectionView(frame: .zero, collectionViewLayout: .init())
        cv.showsVerticalScrollIndicator = false
        cv.register(FilmGalleryCollectionViewCell.self, forCellWithReuseIdentifier: FilmGalleryCollectionViewCell.cellID)
        
        return cv
    }()
    
    private var collecitonViewFlowLayout : UICollectionViewFlowLayout = {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .vertical
        layout.minimumLineSpacing = 5
        layout.minimumInteritemSpacing = 5
        layout.itemSize = CGSize(width: 200, height: 200)
        
        return layout
    }()
    
    private let selectionView : UIView = {
        let view = UIView(frame: .zero)
        view.backgroundColor = .retroOrange
        
        return view
    }()
    
    private let selectedLabel : UILabel = {
        let label = UILabel(frame: .zero)
        label.textAlignment = .center
        label.textColor = .white
        label.font = UIFont.boldSystemFont(ofSize: 14)
        label.text = "사진을 선택해주세요."
        
        return label
    }()
    
    // MARK: - Property
    
    private var fetchResult : PHFetchResult<PHAsset>?
    private var phAssetArray : [UIImage] = []
    private var thumbnailSize = CGSize.zero {
        didSet {
            thumbnailSize = CGSize(width: 1024 * UIScreen.main.scale, height: 1024 * UIScreen.main.scale)
        }
    }
    private var selectedPhotosIndexPath : [IndexPath] = [] {
        didSet {
            if selectedPhotosIndexPath.count > 0 {
                selectedLabel.text = "\(selectedPhotosIndexPath.count)개 선택"
            } else {
                selectedLabel.text = "사진을 선택해주세요."
            }
        }
    }
    
    let film: Film
    
    // MARK: - LifeCycle

    override func viewDidLoad() {
        super.viewDidLoad()
        setUpSubViews()
        setUpFetchAsset()
        setUpCollectionViewDataSource()
    }
    
    init(film : Film) {
        self.film = film
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - Methods
    
    private func setUpSubViews() {
        view.addSubview(collectionView)
        view.addSubview(selectionView)
        selectionView.addSubview(selectedLabel)
        
        let safe = view.safeAreaLayoutGuide
        
        collectionView.snp.makeConstraints {
            $0.edges.equalTo(safe)
        }
        
        selectionView.snp.makeConstraints {
            $0.left.right.equalTo(safe)
            $0.top.equalTo(safe.snp.bottom).offset(-60)
            $0.bottom.equalTo(view.snp.bottom)
        }
        
        selectedLabel.snp.makeConstraints {
            $0.left.right.equalTo(safe)
            $0.top.equalTo(selectionView.snp.top).offset(20)
        }
        
        let tap = UITapGestureRecognizer(target: self, action: #selector(setUpTapGesture))
        selectionView.addGestureRecognizer(tap)
        
        let width = view.frame.width / 3 - 3.5
        collecitonViewFlowLayout.itemSize = CGSize(width: width, height: width)
        collectionView.collectionViewLayout = collecitonViewFlowLayout
    }
    
    private func setUpCollectionViewDataSource() {
        collectionView.rx.setDelegate(self).disposed(by: disposeBag)
        
        Observable.from(optional: phAssetArray)
            .bind(to: collectionView.rx.items(cellIdentifier: FilmGalleryCollectionViewCell.cellID, cellType: FilmGalleryCollectionViewCell.self)) { indexPath, element, cell in
                cell.bindImageView(element)
            }.disposed(by: disposeBag)
        
        collectionView.rx.itemSelected
            .subscribe(onNext: { [weak self] indexPath in
                guard let checkSelf = self else { return }
                
            let cell = checkSelf.collectionView.cellForItem(at: indexPath) as! FilmGalleryCollectionViewCell
            let result = checkSelf.selectedPhotosIndexPath.contains(indexPath)

            if result {
                checkSelf.selectedPhotosIndexPath.removeAll(where: { $0 == indexPath })
            } else {
                checkSelf.selectedPhotosIndexPath.append(indexPath)
            }
            
            cell.bindSelectImageView(isSelected: !result)
        }).disposed(by: disposeBag)
    }
    
    private func setUpFetchAsset() {
        fetchResult = PHAsset.fetchAssets(with: nil)
        
        let options = PHImageRequestOptions()
        options.isSynchronous = true
        options.deliveryMode = .highQualityFormat
        
        let targetSize = CGSize(width: 450, height: 450)
        
        fetchResult?.enumerateObjects { object, index, stop in
            PHImageManager.default().requestImage(for: object as PHAsset, targetSize: targetSize, contentMode: .aspectFit, options: options) { [weak self] result, info in
                guard let image = result else { return }
                self?.phAssetArray.append(image)
            }
        }
    }
    
    @objc private func setUpTapGesture() {
        if !selectedPhotosIndexPath.isEmpty {
            var selectedPhotos : [UIImage] = []
            
            selectedPhotosIndexPath.forEach {
                selectedPhotos.append(phAssetArray[$0.item])
            }
            
            let nextVC = FilmGallerySelectedViewController(photo: selectedPhotos, film: self.film)
            self.navigationController?.pushViewController(nextVC, animated: true)
        }
    }
}



