//
//  filmHeaderCollectionViewCell.swift
//  90s
//
//  Created by 성다연 on 2021/02/15.
//

import UIKit
import SnapKit

/// 필름 뷰 상단 - 헤더셀 입니다
class FilmHeaderCollectionViewCell: UICollectionViewCell {
    static let headerCellID = "headerCell"
    
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
    
    private(set) var viewModel = FilmsViewModel().array

    override init(frame: CGRect) {
        super.init(frame: frame)
        setUpCollectionView()
        setUpSubviews()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

extension FilmHeaderCollectionViewCell {
    func setUpCollectionView(){
        collectionView.delegate = self
        collectionView.dataSource = self
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
        
        filmCountLabel.text = "총 \(viewModel.count - 1)개"
    }
}


extension FilmHeaderCollectionViewCell : UICollectionViewDelegate, UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return viewModel.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: FilmCollectionViewCell.filmCellID, for: indexPath) as? FilmCollectionViewCell else { return UICollectionViewCell() }
        cell.filmImageView.image = UIImage(named: viewModel[indexPath.row].filmImage)
        cell.filmImageLabel.text = viewModel[indexPath.row].filmName
        return cell
    }

    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        return 18
    }
}

extension FilmHeaderCollectionViewCell : UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: 80, height: 140)
    }
}
