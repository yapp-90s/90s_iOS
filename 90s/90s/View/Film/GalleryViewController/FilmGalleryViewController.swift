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

// TODO: - 할 일 : ViewModel 생성, RxCollectionView 변환, 이미지 분할 -> Rx 바인딩

final class FilmGalleryViewController: BaseViewController {

    private let collectionView : UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .vertical
        
        let cv = UICollectionView(frame: .zero, collectionViewLayout: layout)
        cv.showsVerticalScrollIndicator = false
        
        cv.register(FilmGalleryCollectionViewCell.self, forCellWithReuseIdentifier: FilmGalleryCollectionViewCell.cellID)
        return cv
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
    var film: Film
    
    private var thumbnailSize = CGSize.zero
    private var selectedPhotosIndexPath : [IndexPath] = [] {
        didSet {
            if selectedPhotosIndexPath.count > 0 {
                selectedLabel.text = "\(selectedPhotosIndexPath.count)개 선택"
            } else {
                selectedLabel.text = "사진을 선택해주세요."
            }
        }
    }
    
    // MARK: - LifeCycle
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        fetchResult = nil
        phAssetArray = []
        
        setUpFetchAsset()
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        
        setUpSubViews()
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
            $0.bottom.left.right.equalTo(safe)
            $0.height.equalTo(110)
        }
        
        selectedLabel.snp.makeConstraints {
            $0.left.right.equalTo(safe)
            $0.top.equalTo(selectionView.snp.top).offset(20)
        }
        
        let tap = UITapGestureRecognizer(target: self, action: #selector(setUpTapGesture))
        selectionView.addGestureRecognizer(tap)
        
        collectionView.delegate = self
        collectionView.dataSource = self
        
        thumbnailSize = CGSize(width: 1024 * UIScreen.main.scale, height: 1024 * UIScreen.main.scale)
    }
    
    private func setUpFetchAsset() {
        fetchResult = PHAsset.fetchAssets(with: nil)
        
        let options = PHImageRequestOptions()
        options.isSynchronous = true
        options.deliveryMode = .highQualityFormat
        
        let targetSize = CGSize(width: 450, height: 450)
        
        fetchResult?.enumerateObjects { object, index, stop in
            PHImageManager.default().requestImage(for: object as PHAsset, targetSize: targetSize, contentMode: .aspectFit, options: options) { [weak self] image, info in
                self?.phAssetArray.append(image!)
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


extension FilmGalleryViewController : UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return phAssetArray.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: FilmGalleryCollectionViewCell.cellID, for: indexPath) as! FilmGalleryCollectionViewCell
        cell.bindImageView(phAssetArray[indexPath.item])
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let cell = collectionView.cellForItem(at: indexPath) as! FilmGalleryCollectionViewCell
        let result = selectedPhotosIndexPath.contains(indexPath)
        
        if result {
            selectedPhotosIndexPath.removeAll(where: { $0 == indexPath })
        } else {
            selectedPhotosIndexPath.append(indexPath)
        }
        cell.bindSelectImageView(isSelected: !result)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let width = view.frame.width / 3 - 3.5
        return CGSize(width: width, height: width)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 5
    }
        
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        return 5
    }
}

