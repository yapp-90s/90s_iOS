//
//  filmHeaderCollectionViewCell.swift
//  90s
//
//  Created by 성다연 on 2021/02/15.
//

import UIKit
import SnapKit
import RxSwift

/// 필름 뷰 상단 - 헤더셀 입니다
class FilmHeaderCollectionViewCell: UICollectionViewCell {
    static let headerCellID = "headerCell"
    private let viewModel = FilmsViewModel()
    private var disposeBag = DisposeBag()
    
    /// 필름을 보여주는 콜렉션 뷰입니다
    private var collectionView = UICollectionView(frame: .zero, collectionViewLayout: UICollectionViewFlowLayout())
    
    private let filmTitleLabel : UILabel = {
        let label = UILabel(frame: .zero)
        label.text = "내 필름"
        label.font = UIFont.boldSystemFont(ofSize: 22)
        return label
    }()
    
    private var filmCountLabel : UILabel  = {
        let label = UILabel(frame: .zero)
        label.text = "총 0개"
        label.textColor = .gray
        label.font = label.font.withSize(16)
        return label
    }()
    
    private let printedTitleLabel : UILabel = {
        let label = UILabel(frame: .zero)
        label.text = "인화된 사진"
        label.font = UIFont.boldSystemFont(ofSize: 22)
        return label
    }()
    
    /// 추후 이미지 달고 버튼으로 바뀔 것
    private let goToPrintedAlbumLabel : UILabel = {
        let label = UILabel(frame: .zero)
        label.text = "모두보기"
        label.font = label.font.withSize(16)
        label.textColor = .gray
        return label
    }()

    override init(frame: CGRect) {
        super.init(frame: frame)
        setUpCollectionView()
        setUpSubviews()
        bindViewModel()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

extension FilmHeaderCollectionViewCell {
    func bindViewModel(){
        /// set CollectionView DataSource
        viewModel.FilmObservable
            .bind(to: collectionView.rx.items(cellIdentifier: FilmCollectionViewCell.filmCellID, cellType: FilmCollectionViewCell.self)) { index, item, cell in
                cell.filmImageView.image = UIImage(named: item.filmImage)
                cell.filmImageLabel.text = item.filmName
            }
            .disposed(by: disposeBag)
        
        viewModel.itemCount
            .map { "총 \($0 - 1)개" }
            .asDriver(onErrorJustReturn: "")
            .drive(filmCountLabel.rx.text)
            .disposed(by: disposeBag)
    }
    
    func setUpCollectionView(){
        collectionView.delegate = self
        collectionView.backgroundColor = .white
        
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .horizontal
        collectionView.collectionViewLayout = layout
        collectionView.contentInset = UIEdgeInsets(top: 0, left: 18, bottom: 0, right: 18)
        collectionView.showsHorizontalScrollIndicator = false
        collectionView.register(FilmCollectionViewCell.self, forCellWithReuseIdentifier: FilmCollectionViewCell.filmCellID)
    }
    
    func setUpSubviews(){
        contentView.isUserInteractionEnabled = true
        
        self.addSubview(collectionView)
        self.addSubview(filmTitleLabel)
        self.addSubview(filmCountLabel)
        self.addSubview(printedTitleLabel)
        self.addSubview(goToPrintedAlbumLabel)
        
        filmTitleLabel.snp.makeConstraints {
            $0.left.equalTo(18)
            $0.top.equalTo(30)
        }
        
        filmCountLabel.snp.makeConstraints {
            $0.right.equalTo(-35)
            $0.top.equalTo(35)
        }
        
        collectionView.snp.makeConstraints {
            $0.top.equalTo(filmTitleLabel.snp.bottom).offset(18)
            $0.height.equalTo(140)
            $0.left.right.equalTo(self)
        }
        
        printedTitleLabel.snp.makeConstraints {
            $0.left.equalTo(18)
            $0.top.equalTo(collectionView.snp.bottom).offset(42)
        }
        
        goToPrintedAlbumLabel.snp.makeConstraints {
            $0.right.equalTo(-35)
            $0.top.equalTo(collectionView.snp.bottom).offset(44)
        }
    }
}


extension FilmHeaderCollectionViewCell : UICollectionViewDelegate  {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        return 18
    }
}

extension FilmHeaderCollectionViewCell : UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: 80, height: 140)
    }
}
