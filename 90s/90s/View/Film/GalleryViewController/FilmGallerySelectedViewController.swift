//
//  FilmGallerySelectedViewController.swift
//  90s
//
//  Created by 성다연 on 2021/11/08.
//

import UIKit
import SnapKit
import RxSwift

// TODO: - 할 일 : ViewModel 생성, 앨범 사진 데이터 추가 로직

final class FilmGallerySelectedViewController: BaseViewController, UIScrollViewDelegate {
    
    private let collectionView : UICollectionView = {
        let cv = UICollectionView(frame: .zero, collectionViewLayout: .init())
        cv.showsHorizontalScrollIndicator = false
        cv.register(reusable: FilmGallerySelectedCollectionViewCell.self)
        
        return cv
    }()
    
    private let collectionViewFlowLayout : UICollectionViewFlowLayout = {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .horizontal
        
        return layout
    }()
    
    private let infoLabel : UILabel = {
        let label = UILabel(frame: .zero)
        label.textColor = .lightGray
        label.numberOfLines = 2
        
        return label
    }()
    
    private let completeButton : UIButton = {
        let button = UIButton(frame: .zero)
        button.setTitle("앨범에 넣기", for: .normal)
        button.setTitleColor(.white, for: .normal)
        button.titleLabel?.font = UIFont.boldSystemFont(ofSize: 14)
        button.titleLabel?.textAlignment = .center
        button.backgroundColor = .retroOrange
        
        return button
    }()
    
    // MARK: - Properties
    
    private var film : Film
    private var photos : [UIImage] = []
    
    // MARK: - Life Cycle

    init(_ photos: [UIImage], film: Film) {
        self.photos = photos
        self.film = film
        super.init(nibName: nil, bundle: nil)
    }
    
    convenience init(photo array : [UIImage], film: Film){
        self.init([], film: film)
        self.photos = array
        collectionView.reloadData()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setUpSubViews()
        setInfoView()
        setUpCollectionViewDataSource()
    }
    
    // MARK: - Methods
    
    private func setUpSubViews() {
        view.addSubview(collectionView)
        view.addSubview(infoLabel)
        view.addSubview(completeButton)
        
        let safe = view.safeAreaLayoutGuide
        
        completeButton.snp.makeConstraints {
            $0.left.equalTo(safe).offset(45)
            $0.right.equalTo(safe).offset(-45)
            $0.height.equalTo(60)
            $0.bottom.equalTo(safe).offset(-80)
        }
        
        infoLabel.snp.makeConstraints {
            $0.left.right.equalTo(safe)
            $0.bottom.equalTo(completeButton.snp.top).offset(-45)
        }
        
        collectionView.snp.makeConstraints {
            $0.top.left.right.equalTo(safe)
            $0.bottom.equalTo(infoLabel.snp.top).offset(-16)
        }
        
        self.completeButton.rx.tap
            .asDriver().drive(onNext: {
//                self.requestUploadPhotos()
//                var array : [Photo] = []
//                photos.forEach { array.append()}
//                film.photos.
//                film.photos.append(contentsOf: photos)
            })
            .disposed(by: disposeBag)
    }
    
    private func setUpCollectionViewDataSource() {
        let itemSize = CGSize(width: view.frame.width - 10, height: 400)
        collectionViewFlowLayout.itemSize = itemSize
        collectionView.collectionViewLayout = collectionViewFlowLayout
        
        collectionView.rx.setDelegate(self).disposed(by: disposeBag)

        Observable.from(optional: photos)
            .bind(to: collectionView.rx.items(cellIdentifier: FilmGallerySelectedCollectionViewCell.reuseIdentifier, cellType: FilmGallerySelectedCollectionViewCell.self)) { indexPath, element, cell in
                cell.bindImageView(photo: element)
            }.disposed(by: disposeBag)
    }
    
    private func setInfoView() {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy.MM.dd"
        
        let today = dateFormatter.string(from: Date())
        let attr = [NSAttributedString.Key.font : UIFont.boldSystemFont(ofSize: 13)]
        let attributedString = NSMutableAttributedString(string: "생성일\n" + today,attributes: attr)
       
        let paragraphStyle = NSMutableParagraphStyle()
        paragraphStyle.alignment = .center
        paragraphStyle.lineSpacing = 8
        attributedString.addAttribute(NSAttributedString.Key.paragraphStyle, value: paragraphStyle, range: NSMakeRange(0, attributedString.length))
        
        infoLabel.attributedText = attributedString
    }
    
    private func requestUploadPhotos() {
        photos.forEach { photo in
            PhotoService.shared.upload(photo: (image: photo, filmUid : film.uid)) { result in
                switch result {
                case let .success(response):
                    print("FilmGallerySelectedVC - success request : uploadPhoto, ", response)
                case let .failure(response):
                    print("FilmGallerySelectedVC - error : uploadPhoto, ", response)
                }
            }
        }
    }
}

