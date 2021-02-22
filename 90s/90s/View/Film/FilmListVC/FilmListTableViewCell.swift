//
//  FilmListCollectionViewCell.swift
//  90s
//
//  Created by 성다연 on 2021/02/20.
//

import UIKit
import SnapKit
import RxSwift
import RxCocoa

/// 필름 리스트를 보여주는 테이블 셀
class FilmListTableViewCell: UITableViewCell {
    static let FilmListCellId = "filmListCell"
    
    private let viewModel = FilmsViewModel()
    private var disposeBag = DisposeBag()
    
    private var collectionView : UICollectionView = {
        let cv = UICollectionView(frame: .zero, collectionViewLayout: .init())
        cv.showsHorizontalScrollIndicator = false
        return cv
    }()
    
    private var FilmTitleLabel : UILabel = {
        let label = UILabel(frame: .zero)
        label.font = UIFont.boldSystemFont(ofSize: 16)
        label.text = "필름 이름"
        return label
    }()
    
    private var FilmCount_DateLabel : UILabel = {
        let label = UILabel(frame: .zero)
        label.font = label.font.withSize(13)
        label.text = "ㅁ/ㅁ장  -  0000.00.00"
        label.textColor = .gray
        return label
    }()
    
    /// 필름 상태를 보여주는 이미지 뷰
    private var FilmTypeImageView : UIImageView = {
        let iv = UIImageView(frame: .zero)
        return iv
    }()
    
    /// 필름 대표 이미지 뷰
    private var FilmTitleImageView : UIImageView = {
        let iv = UIImageView(frame: .zero)
        return iv
    }()
    
    private var FilmBackgroudImageView : UIImageView = {
        let iv = UIImageView(frame: .zero)
//        iv.image = UIImage(named: "film_preview_roll")
        iv.image = UIImage(named: "filmbackgroundimg")
        return iv
    }()
    
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setUpSubViews()
        setUpCollectionView()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}


extension FilmListTableViewCell : UICollectionViewDelegate {
    private func setUpSubViews(){
        self.addSubview(FilmBackgroudImageView)
        self.addSubview(FilmTitleImageView)
        self.addSubview(collectionView)
        self.addSubview(FilmTitleLabel)
        self.addSubview(FilmCount_DateLabel)
        self.addSubview(FilmTypeImageView)
        
       
        FilmTitleImageView.snp.makeConstraints {
            $0.width.equalTo(100)
            $0.height.equalTo(140)
            $0.left.equalTo(18)
            $0.top.equalTo(18)
        }
        
        FilmBackgroudImageView.snp.makeConstraints {
            $0.width.equalTo(275)
            $0.height.equalTo(110)
            $0.right.equalTo(-28)
            $0.top.equalTo(30)
        }
        
        collectionView.snp.makeConstraints {
            $0.left.equalTo(FilmBackgroudImageView.snp.left).offset(8)
            $0.right.equalTo(FilmBackgroudImageView.snp.right)
            $0.top.equalTo(FilmBackgroudImageView.snp.top).offset(15)
            $0.bottom.equalTo(FilmBackgroudImageView.snp.bottom).offset(-15)
        }
        
        FilmTitleLabel.snp.makeConstraints {
            $0.left.equalTo(20)
            $0.top.equalTo(FilmTitleImageView.snp.bottom).offset(8)
        }
        
        FilmCount_DateLabel.snp.makeConstraints {
            $0.left.equalTo(20)
            $0.top.equalTo(FilmTitleLabel.snp.bottom).offset(2)
        }
        
        FilmTypeImageView.snp.makeConstraints {
            $0.height.equalTo(21)
            $0.width.equalTo(84)
            $0.bottom.equalTo(-22)
            $0.right.equalTo(-18)
        }
    }
    
    func setUpCollectionView(){
        collectionView.delegate = self
        collectionView.register(FilmListCollectionViewCell.self, forCellWithReuseIdentifier: FilmListCollectionViewCell.filmListCCellId)
        
        viewModel.FilmObservable
            .bind(to: collectionView.rx.items(cellIdentifier: FilmListCollectionViewCell.filmListCCellId, cellType: FilmListCollectionViewCell.self)) { index, item, cell in
            cell.bindViewModel(item: item.photos[index])
        }
        .disposed(by: disposeBag)
    }
    
    func bindViewModel(film: Film){
        FilmTitleImageView.image = UIImage(named: film.filterType.image())
        FilmTitleLabel.text = film.name
        FilmCount_DateLabel.text = film.createDate // 전체 개수 리턴하는 함수 필요
        FilmTypeImageView.image = UIImage(named: film.state.image())
    }
}


extension FilmListTableViewCell : UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        return 6
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: 80, height: 80)
    }
}
