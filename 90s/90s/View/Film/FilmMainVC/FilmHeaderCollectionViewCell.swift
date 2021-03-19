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
    static let cellID = "headerCell"
    
    private let viewModel = FilmsViewModel()
    private var disposeBag = DisposeBag()
    var delegate : FilmVCDelegate?
    
    /// 필름을 보여주는 콜렉션 뷰입니다
    private var collectionView : UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .horizontal
        let cv = UICollectionView(frame: .zero, collectionViewLayout: layout)
        cv.contentInset = UIEdgeInsets(top: 0, left: 18, bottom: 0, right: 18)
        cv.showsHorizontalScrollIndicator = false
        return cv
    }()
    
    private let filmTitleLabel : UILabel = {
        let label = LabelType.bold_21.create()
        label.text = "내 필름"
        return label
    }()
    
    private var filmCountBtn : UIButton = {
        let btn = UIButton(frame: .zero)
        btn.titleLabel?.font = .systemFont(ofSize: 16)
        btn.setTitleColor(.gray, for: .normal)
        btn.setImage(UIImage(named: "point"), for: .normal)
        btn.semanticContentAttribute = .forceRightToLeft
        btn.imageEdgeInsets = UIEdgeInsets(top: 0, left: 16, bottom: 3, right: 0)
        return btn
    }()
    
    private let printedTitleLabel : UILabel = {
        let label = LabelType.bold_21.create()
        label.text = "인화된 사진"
        return label
    }()

    override init(frame: CGRect) {
        super.init(frame: frame)
        setUpSubviews()
        setUpCollectionView()
        bindViewModel()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

extension FilmHeaderCollectionViewCell {
    private func setUpSubviews(){
        contentView.isUserInteractionEnabled = true
        
        addSubview(collectionView)
        addSubview(filmTitleLabel)
        addSubview(filmCountBtn)
        addSubview(printedTitleLabel)
        
        filmTitleLabel.snp.makeConstraints {
            $0.left.equalTo(18)
            $0.top.equalTo(30)
        }
        
        filmCountBtn.snp.makeConstraints {
            $0.width.equalTo(54)
            $0.height.equalTo(24)
            $0.right.equalTo(-35)
            $0.top.equalTo(31)
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
    }
    
    private func setUpCollectionView(){
        collectionView.delegate = self
        collectionView.register(FilmCollectionViewCell.self, forCellWithReuseIdentifier: FilmCollectionViewCell.cellID)
    }
    
    private func bindViewModel(){
        let attribute = NSMutableAttributedString(string: "")
        let imageAttachment = NSTextAttachment()
        imageAttachment.image = UIImage(named: "point")
        attribute.append(attribute)
        
        /// set CollectionView DataSource
        viewModel.FilmObservable
            .bind(to: collectionView.rx.items(cellIdentifier: FilmCollectionViewCell.cellID, cellType: FilmCollectionViewCell.self)) { index, item, cell in
                cell.bindItem(film: item)
            }
            .disposed(by: disposeBag)
        
        viewModel.itemCount
            .map { "총 \($0 - 1)개" }
            .asDriver(onErrorJustReturn: "")
            .drive(filmCountBtn.rx.title(for: .normal))
            .disposed(by: disposeBag)
        
        filmCountBtn.rx.tap.bind { [weak self] in
            self?.delegate?.presentListVC()
        }.disposed(by: disposeBag)
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
