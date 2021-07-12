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
final class FilmMainHeaderCollectionViewCell: UICollectionViewCell {
    /// 필름을 보여주는 콜렉션 뷰입니다
    private var collectionView : UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .horizontal
        
        let cv = UICollectionView(frame: .zero, collectionViewLayout: layout)
        cv.contentInset = UIEdgeInsets(top: 0, left: 18, bottom: 0, right: 18)
        cv.showsHorizontalScrollIndicator = false
        
        cv.register(FilmMainCollectionViewCell.self, forCellWithReuseIdentifier: FilmMainCollectionViewCell.cellID)
        
        return cv
    }()
    
    private let filmTitleLabel : UILabel = {
        let label = LabelType.bold_21.create()
        label.text = "내 필름"
        return label
    }()
    
    private var filmCountButton : UIButton = {
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
    
    // MARK: - Property
    
    static let cellID = "headerCell"
    private let viewModel = FilmsViewModel(dependency: .init())
    private var disposeBag = DisposeBag()
    var delegate : FilmMainViewControllerDelegate?

    // MARK: - Init
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setUpSubviews()
        bindViewModel()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - Method

    private func setUpSubviews(){
        contentView.isUserInteractionEnabled = true
        
        addSubview(collectionView)
        addSubview(filmTitleLabel)
        addSubview(filmCountButton)
        addSubview(printedTitleLabel)
        
        collectionView.rx.setDelegate(self).disposed(by: disposeBag)
        
        filmTitleLabel.snp.makeConstraints {
            $0.left.equalTo(18)
            $0.top.equalTo(30)
        }
        
        filmCountButton.snp.makeConstraints {
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
    
    private func bindViewModel(){
        let attribute = NSMutableAttributedString(string: "")
        let imageAttachment = NSTextAttachment()
        imageAttachment.image = UIImage(named: "point")
        attribute.append(attribute)

        /// set CollectionView DataSource
        viewModel.output.films
            .bind(to: collectionView.rx.items(cellIdentifier: FilmMainCollectionViewCell.cellID, cellType: FilmMainCollectionViewCell.self)) { index, item, cell in
                cell.bindItem(film: item)
            }
            .disposed(by: disposeBag)
        
        viewModel.output.films
            .map { $0.map { $0.id}}
            .map { "총 \($0.count - 1)개" }
            .asDriver(onErrorJustReturn: "")
            .drive(filmCountButton.rx.title(for: .normal))
            .disposed(by: disposeBag)
        
        collectionView.rx.itemSelected.subscribe(onNext: { indexPath in
            if indexPath.row == 0 {
                self.delegate?.presentCreateVC()
            }
        }).disposed(by: disposeBag)
        
        filmCountButton.rx.tap.bind { [weak self] in
            self?.delegate?.presentListVC()
        }.disposed(by: disposeBag)
    }
}


extension FilmMainHeaderCollectionViewCell : UICollectionViewDelegate, UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        return 18
    }

    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: 80, height: 140)
    }
}
