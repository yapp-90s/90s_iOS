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
    
    private var collectionView = UICollectionView(frame: .zero)
    private var disposeBag = DisposeBag()
    
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
    
    /// stackView에 들어가는 이미지 뷰
    private var FilmArrayImageView : UIImageView = {
        let iv = UIImageView(frame: .zero)
        return iv
    }()
   
    override func awakeFromNib() {
        super.awakeFromNib()
        setUpSubViews()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}


extension FilmListTableViewCell {
    private func setUpSubViews(){
        self.addSubview(FilmTitleImageView)
        self.addSubview(collectionView)
        self.addSubview(FilmTitleLabel)
        self.addSubview(FilmCount_DateLabel)
        self.addSubview(FilmTypeImageView)
       
        FilmTitleImageView.snp.makeConstraints {
            $0.width.equalTo(100)
            $0.height.equalTo(140)
            $0.left.equalTo(18)
            $0.top.equalTo(10)
        }
        
        collectionView.snp.makeConstraints {
            $0.left.equalTo(FilmTitleImageView.snp.right)
            $0.right.equalTo(-18)
            $0.height.equalTo(280)
            $0.top.equalTo(25)
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
            $0.top.equalTo(22)
            $0.right.equalTo(-18)
        }
    }
    
    
    func bindViewModel(film: Film){
        FilmTitleImageView.image = UIImage(named: film.filterType.image())
        FilmTitleLabel.text = film.name
        FilmCount_DateLabel.text = film.createDate // 전체 개수 리턴하는 함수 필요
        FilmTypeImageView.image = UIImage(named: film.state.image())
        
        /// 콜렉션에 넣어주는 코드 필요
        
    }
}


