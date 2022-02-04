//
//  FilmListDetailViewController.swift
//  90s
//
//  Created by 성다연 on 2021/03/14.
//

import UIKit
import PhotosUI
import SnapKit
import RxSwift

/// 필름 정보와 사진을 보여주는 VC
final class FilmListDetailViewController: BaseViewController, UIScrollViewDelegate {
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
    
    private var collectionViewFlowLayout : UICollectionViewFlowLayout = {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .vertical
        
        return layout
    }()
 
    private var collectionView : UICollectionView = {
        let cv = UICollectionView(frame: .zero, collectionViewLayout: .init())
        cv.showsVerticalScrollIndicator = false
        cv.register(reusable: FilmListCollectionViewCell.self)
        
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
    
    // MARK: - Property
    
    private var viewModel : Film
    private var selectPhotos = [UIImage]()
    
    // MARK: - LifeCycle
    
    init(viewModel : Film) {
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)
        bindViewModel()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setUpSubViews()
        setUpCollectionViewDataSource()
        setUpCollectionViewFlowLayout()
    }
    
    // MARK: - Methods

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
            self.setPhPicker(photoMax: self.viewModel.filmType.max, photoFill: self.viewModel.count)
        }.disposed(by: disposeBag)
    }
    
    private func setUpCollectionViewDataSource() {
        collectionView.rx.setDelegate(self).disposed(by: disposeBag)
        
        Observable.from(optional: viewModel.photos)
            .bind(to: collectionView.rx.items(cellIdentifier: FilmListCollectionViewCell.reuseIdentifier , cellType: FilmListCollectionViewCell.self)) { indexPath, element, cell in
                cell.bindViewModel(item: element)
        collectionView.rx.itemSelected
            .subscribe(onNext: { [weak self] indexPath in
                guard let checkSelf = self else { return }
                let film = checkSelf.viewModel
                if indexPath.row == 0 && film.filmType.max > film.count {
                    checkSelf.setPhPicker(photoMax: film.filmType.max, photoFill: film.count)
                }
            }).disposed(by: disposeBag)
    }
    
    private func setUpCollectionViewFlowLayout() {
        let cellSize = (view.frame.width - 36) / 2 - 5
        collectionViewFlowLayout.itemSize = CGSize(width: cellSize, height: cellSize)
        collectionView.collectionViewLayout = collectionViewFlowLayout
    }

    private func setPhPicker(photoMax maxCount : Int, photoFill fillCount : Int) {
        checkGalleryPermission()
    }
    
    /// 사진 권한 상태 체크
    private func checkGalleryPermission() {
        switch PHPhotoLibrary.authorizationStatus() {
        case .authorized:
            self.presentNextViewController()
            print("Photo Access : 권한 허용")
        case .notDetermined, .restricted, .denied :
            self.requestGalleryPermission()
            print("Photo Access : 권한 거부")
        default:
            break
        }
    }
    
    /// 사진 권한 요청
    private func requestGalleryPermission() {
        PHPhotoLibrary.requestAuthorization() { status in
            switch status {
            case .authorized:
                self.presentNextViewController()
                print("Photo Access : 권한 허용")
            case .notDetermined, .restricted, .denied :
                self.showDeniedPermissonAlert()
                print("Photo Access : 권한 거부")
            default:
                break
            }
        }
     }
    
    /// 사진 권한 접근 불가 상태로 갤러리 접근 시 띄우는 알림창
    private func showDeniedPermissonAlert() {
        let alert = UIAlertController(title: "사진 권한 요청", message: "사진 권한이 없어 갤러리에 접근이 불가합니다.", preferredStyle: .alert)
        let confirm = UIAlertAction(title: "확인", style: .default)
        alert.addAction(confirm)
        
        present(alert, animated: true)
    }
    
    private func presentNextViewController() {
        let nextVC = FilmGalleryViewController(film: viewModel)
        
        DispatchQueue.main.async {
            self.navigationController?.pushViewController(nextVC, animated: true)
        }
    }
    
    func bindViewModel() {
        let photoCount = viewModel.photos.count
        
        DispatchQueue.main.async { [weak self] in
            guard let self = self else {return}
            self.filmImageView.image = UIImage(named: self.viewModel.filmType.image)
        }
        filmNameLabel.text = viewModel.name
        filmDateLabel.text = viewModel.createdAt
        filmCountLabel.text = "\(viewModel.count)/\(viewModel.filmType.max)장"
        filmTypeLabel.text = viewModel.filmState.tagText()
        
        
        if viewModel.filmType.max != photoCount && photoCount > 0 {    // 사진이 채워지는 중인 경우
            let photo = Photo(photoUid: 0, paperNum: 0, sequence: 0, url: "film_add_photo")
            self.viewModel.addAtFirst(photo)
        } else if viewModel.count == 0 {     // 사진이 하나도 없는 경우
            emptyImageView.isHidden = false
            emptyAddMoreButton.isHidden = false
            printButton.isHidden = true
        } else {                        // 사진이 다 찬 경우
            printButton.isHidden = false
        }
        
        collectionView.reloadData()
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
