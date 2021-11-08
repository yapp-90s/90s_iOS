//
//  FilmGallerySelectedViewController.swift
//  90s
//
//  Created by 성다연 on 2021/11/08.
//

import UIKit

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
        label.textAlignment = .center
        label.font = .boldSystemFont(ofSize: 13)
        label.text = "생성일\n2021.11.08"
        
        return label
    }()
    
    private let completeButton : UIButton = {
        let button = UIButton(frame: .zero)
        button.titleLabel!.text = "앨범에 넣기"
        button.titleLabel!.font = UIFont.boldSystemFont(ofSize: 14)
        button.titleLabel!.textColor = .white
        button.titleLabel!.textAlignment = .center
        button.backgroundColor = .retroOrange
        
        return button
    }()
    
    private var photos : [UIImage] = []

    override init(nibName nibNameOrNil: String?, bundle nibBundleOrNil: Bundle?) {
        super.init(nibName: nibNameOrNil, bundle: nibBundleOrNil)
    }
    
    convenience init(photo array : [UIImage]){
        self.init(nibName: nil, bundle: nil)
        self.photos = array
        collectionView.reloadData()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setUpSubViews()
    }
    
    private func setUpSubViews() {
        view.addSubview(collectionView)
        view.addSubview(infoLabel)
        view.addSubview(completeButton)
        
        let safe = view.safeAreaLayoutGuide
        
        collectionView.translatesAutoresizingMaskIntoConstraints = false
        collectionView.topAnchor.constraint(equalTo: safe.topAnchor,constant: 10).isActive = true
        collectionView.heightAnchor.constraint(equalToConstant: 450).isActive = true
        collectionView.rightAnchor.constraint(equalTo: safe.rightAnchor).isActive = true
        collectionView.leftAnchor.constraint(equalTo: safe.leftAnchor).isActive = true
        
        infoLabel.translatesAutoresizingMaskIntoConstraints = false
        infoLabel.topAnchor.constraint(equalTo: collectionView.bottomAnchor, constant: 14).isActive = true
        infoLabel.leftAnchor.constraint(equalTo: collectionView.leftAnchor).isActive = true
        infoLabel.rightAnchor.constraint(equalTo: collectionView.rightAnchor).isActive = true
        
        completeButton.translatesAutoresizingMaskIntoConstraints = false
        completeButton.topAnchor.constraint(equalTo: infoLabel.bottomAnchor, constant: 50).isActive = true
        completeButton.leftAnchor.constraint(equalTo: safe.leftAnchor, constant: 45).isActive = true
        completeButton.rightAnchor.constraint(equalTo: safe.rightAnchor, constant: -45).isActive = true
        completeButton.heightAnchor.constraint(equalToConstant: 60).isActive = true
        
        collectionView.delegate = self
        collectionView.dataSource = self
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
        return CGSize(width: 400, height: 400)
    }
}
