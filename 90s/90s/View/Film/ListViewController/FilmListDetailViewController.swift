//
//  FilmListDetailViewController.swift
//  90s
//
//  Created by 성다연 on 2021/03/14.
//

import UIKit
import PhotosUI
import SnapKit

/// 필름 정보와 사진을 보여주는 VC
final class FilmListDetailViewController: BaseViewController, UINavigationControllerDelegate, PHPickerViewControllerDelegate {
    private let filmImageView : UIImageView = {
        let iv = UIImageView(frame: .zero)
        iv.image = UIImage(named: "film_default")
        return iv
    }()
    
    private let filmNameLabel : UILabel = {
        let label = UILabel(frame: .zero)
        label.font = .Film_Title
        label.text = "필름이름"
        return label
    }()
    
    private let filmTypeLabel : UILabel = {
        let label = UILabel(frame: .zero)
        label.font = .Small_Text
        label.textColor = .gray
        label.text = "사진 추가 중"
        return label
    }()
    
    private let filmDateLabel : UILabel = {
        let label = UILabel(frame: .zero)
        label.font = .Film_Sub_Title
        label.textColor = .gray
        label.text = "2021.03.14"
        return label
    }()
    
    private let filmCountLabel : UILabel = {
        let label = UILabel(frame: .zero)
        label.font = .Large_Text
        label.text = "장"
        return label
    }()
    
    private var collectionView : UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .vertical
        
        let cv = UICollectionView(frame: .zero, collectionViewLayout: layout)
        cv.showsVerticalScrollIndicator = false
        cv.register(FilmListCollectionViewCell.self, forCellWithReuseIdentifier: FilmListCollectionViewCell.cellId)
        return cv
    }()
    
    private let printButton : UIButton = {
        let btn = UIButton(frame: .zero)
        btn.layer.cornerRadius = 15
        btn.clipsToBounds = true
        btn.titleLabel?.font = .systemFont(ofSize: 12)
        btn.setTitle("인화하기", for: .normal)
        btn.setTitleColor(.white, for: .normal)
        btn.backgroundColor = .warmLightgray
        return btn
    }()
    
    private let emptyImageView: UIImageView = {
        let iv = UIImageView(frame: .zero)
        iv.image = UIImage(named: "film_photo_empty")
        iv.isHidden = true
        return iv
    }()
    
    private let emptyAddMoreButton: UIButton = {
        let btn = UIButton(frame: .zero)
        btn.layer.cornerRadius = 5
        btn.clipsToBounds = true
        btn.titleLabel?.font = .boldSystemFont(ofSize: 16)
        btn.setTitle("사진 추가하기", for: .normal)
        btn.setTitleColor(.white, for: .normal)
        btn.backgroundColor = .retroOrange
        btn.isHidden = true
        return btn
    }()
    
    private var films : Film?
    private var selectPhotos = [UIImage]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setUpSubViews()
    }

    private func setUpSubViews() {
        view.overrideUserInterfaceStyle = .dark
        navigationController?.navigationBar.isHidden = false
       
        view.addSubview(collectionView)
        view.addSubview(filmImageView)
        view.addSubview(filmNameLabel)
        view.addSubview(filmTypeLabel)
        view.addSubview(filmDateLabel)
        view.addSubview(filmCountLabel)
        view.addSubview(printButton)
        
        view.addSubview(emptyImageView)
        view.addSubview(emptyAddMoreButton)
        
        collectionView.delegate = self
        collectionView.dataSource = self
        
        let safe = view.safeAreaLayoutGuide
        
        filmImageView.snp.makeConstraints {
            $0.height.equalTo(164)
            $0.width.equalTo(105)
            $0.left.equalTo(safe).offset(10)
            $0.top.equalTo(safe).offset(2)
        }
        
        filmTypeLabel.snp.makeConstraints {
            $0.top.equalTo(safe).offset(20)
            $0.left.equalTo(filmImageView.snp.right).offset(18)
        }
        
        filmNameLabel.snp.makeConstraints {
            $0.top.equalTo(filmTypeLabel.snp.bottom).offset(14)
            $0.left.equalTo(filmImageView.snp.right).offset(17)
        }
        
        filmDateLabel.snp.makeConstraints {
            $0.top.equalTo(filmNameLabel.snp.bottom).offset(4)
            $0.left.equalTo(filmImageView.snp.right).offset(18)
        }
        
        filmCountLabel.snp.makeConstraints {
            $0.top.equalTo(filmDateLabel.snp.bottom).offset(28)
            $0.left.equalTo(filmImageView.snp.right).offset(17)
        }
        
        // hidden
        printButton.snp.makeConstraints {
            $0.height.equalTo(32)
            $0.width.equalTo(78)
            $0.right.equalTo(safe).offset(-18)
            $0.top.equalTo(filmDateLabel.snp.bottom).offset(24)
        }
        
        collectionView.snp.makeConstraints {
            $0.top.equalTo(filmCountLabel.snp.bottom).offset(55)
            $0.left.equalTo(safe).offset(18)
            $0.right.equalTo(safe).offset(-18)
            $0.bottom.equalTo(safe)
        }
        
        emptyImageView.snp.makeConstraints {
            $0.width.equalTo(163)
            $0.height.equalTo(142)
            $0.top.equalTo(filmCountLabel.snp.bottom).offset(64)
            $0.centerX.equalTo(safe)
        }
        
        emptyAddMoreButton.snp.makeConstraints {
            $0.left.equalTo(45)
            $0.right.equalTo(-45)
            $0.height.equalTo(57)
            $0.top.equalTo(emptyImageView.snp.bottom).offset(50)
        }
        
        emptyAddMoreButton.rx.tap.bind { _ in
            if let film = self.films {
                self.setPhPicker(photoMax: film.maxCount, photoFill: film.count)
            }
        }.disposed(by: disposeBag)
    }
    
    private func setPhPicker(photoMax maxCount : Int, photoFill fillCount : Int) {
            if #available(iOS 14.0, *) {
                var configuration = PHPickerConfiguration()
                configuration.filter = .images
                configuration.selectionLimit = maxCount - fillCount
                
                let picker = PHPickerViewController(configuration: configuration)
                picker.delegate = self
                self.present(picker, animated: true)
            } else {
                let picker = UIImagePickerController()
                picker.sourceType = .photoLibrary
                picker.mediaTypes = ["public.image", "public.movie"]
                picker.delegate = self
                self.present(picker, animated: true)
            }
    }
    
    func bindViewModel(film : Film){
        DispatchQueue.main.async { [weak self] in
            self?.filmImageView.image = UIImage(named: film.filmType.name.image)
        }
        filmNameLabel.text = film.name
        filmDateLabel.text = film.createdAt
        filmCountLabel.text = "\(film.count)/\(film.maxCount)장"
        filmTypeLabel.text = film.state.text()
        
        films = film
        
        if film.maxCount != film.photos.count && film.photos.count > 0 {
            let photo = Photo(photoUid: 0, url: "film_add_photo", date: "")
            films?.addAtFirst(photo)
        } else {
            printButton.isHidden = true
        }
        
        if film.count == 0 {
            emptyImageView.isHidden = false
            emptyAddMoreButton.isHidden = false
            printButton.isHidden = true
        }
        
        collectionView.reloadData()
    }
}


extension FilmListDetailViewController : UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let ratio = collectionView.frame.width / 2 - 5
        return CGSize(width: ratio, height: ratio)
    }
}


extension FilmListDetailViewController : UICollectionViewDelegate, UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        if let f = films {
            return f.photos.count
        }
        return 0
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: FilmListCollectionViewCell.cellId, for: indexPath) as! FilmListCollectionViewCell
        if let f = films {
            cell.bindViewModel(item: f.photos[indexPath.row], isScaleFill: true)
        }
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        if indexPath.row == 0 {
            if let film = films {
                setPhPicker(photoMax: film.maxCount, photoFill: film.count)
            }
        }
    }
}

extension FilmListDetailViewController : UIImagePickerControllerDelegate {
    @available(iOS 14, *)
    func picker(_ picker: PHPickerViewController, didFinishPicking results: [PHPickerResult]) {
        picker.dismiss(animated: true)
        selectPhotos = []
        
        for photo in results {
            let provider = photo.itemProvider
    
            if provider.canLoadObject(ofClass: UIImage.self) {
                provider.loadObject(ofClass: UIImage.self) { image, error in
                    DispatchQueue.main.async { [self] in
                        self.selectPhotos.append(image as! UIImage)
                    }
                }
            }
        }
        // TODO : 현재 필름의 사진 목록에 추가하기
    }
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        selectPhotos = []
        
        if let image = info[UIImagePickerController.InfoKey.originalImage] as? UIImage {
            selectPhotos.append(image)
            dismiss(animated: true, completion: nil)
        }
    }
}
