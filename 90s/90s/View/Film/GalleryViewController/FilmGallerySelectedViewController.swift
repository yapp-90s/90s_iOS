//
//  FilmGallerySelectedViewController.swift
//  90s
//
//  Created by 성다연 on 2021/11/08.
//

import UIKit
import SnapKit

// TODO: - 할 일 : ViewModel 생성, RxCollectionView 변환, 앨범 사진 데이터 추가 로직

final class FilmGallerySelectedViewController: BaseViewController {
    
    private let collectionView : UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .horizontal
        
        let cv = UICollectionView(frame: .zero, collectionViewLayout: layout)
        cv.showsHorizontalScrollIndicator = false
        
        cv.register(FilmGallerySelectedCollectionViewCell.self, forCellWithReuseIdentifier: FilmGallerySelectedCollectionViewCell.cellID)
        
        return cv
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
    
    var film : Film!
    
    var viewModel : [UIImage] = []
    
    private var photos : [UIImage] = []
    
    // MARK: - Life Cycle

    init(_ viewModel: [UIImage], film: Film) {
        self.viewModel = viewModel
        self.film = film
        super.init(nibName: nil, bundle: nil)
        bind()
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
    }
    
    // MARK: - Methods
    
    private func setUpSubViews() {
        view.addSubview(collectionView)
        view.addSubview(infoLabel)
        view.addSubview(completeButton)
        
        let safe = view.safeAreaLayoutGuide
        
        collectionView.snp.makeConstraints {
            $0.top.left.right.equalTo(safe)
            $0.height.equalTo(450)
        }
        
        infoLabel.snp.makeConstraints {
            $0.left.right.equalTo(safe)
            $0.top.equalTo(collectionView.snp.bottom).offset(14)
        }
        
        completeButton.snp.makeConstraints {
            $0.top.equalTo(infoLabel.snp.bottom).offset(50)
            $0.left.equalTo(safe).offset(45)
            $0.right.equalTo(safe).offset(-45)
            $0.height.equalTo(60)
        }
        
        collectionView.delegate = self
        collectionView.dataSource = self
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
    
    private func bind() {
        self.completeButton.rx.tap
            .asDriver().drive(onNext: {
                self.requestUploadPhotos()
//                var array : [Photo] = []
//                photos.forEach { array.append()}
//                film.photos.
//                film.photos.append(contentsOf: photos)
            })
            .disposed(by: disposeBag)
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

extension FilmGallerySelectedViewController : UICollectionViewDataSource, UICollectionViewDelegate, UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return photos.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: FilmGallerySelectedCollectionViewCell.cellID, for: indexPath) as! FilmGallerySelectedCollectionViewCell
        
        cell.bindImageView(photo: photos[indexPath.item])
        
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: view.frame.width - 10, height: 400)
    }
}
