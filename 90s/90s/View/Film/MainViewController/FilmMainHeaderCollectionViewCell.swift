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
final class FilmMainHeaderCollectionViewCell: UICollectionViewCell, UIScrollViewDelegate {
    /// 필름을 보여주는 콜렉션 뷰입니다
    private var collectionView : UICollectionView = {
        let cv = UICollectionView(frame: .zero, collectionViewLayout: .init())
        cv.contentInset = UIEdgeInsets(top: 0, left: 18, bottom: 0, right: 18)
        cv.showsHorizontalScrollIndicator = false
        
        cv.register(reusable: FilmMainCollectionViewCell.self)
        return cv
    }()
    
    private let filmTitleLabel : UILabel = {
        let label = UILabel(frame: .zero)
        label.font = .Head
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
        let label = UILabel(frame: .zero)
        label.font = .Head
        label.text = "인화된 사진"
        return label
    }()
    
    // MARK: - Property
    
    private var viewModel = FilmsViewModel(dependency: .init())
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
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .horizontal
        layout.itemSize = .init(width: 80, height: 163)
        layout.minimumInteritemSpacing = 16
        
        collectionView.collectionViewLayout = layout
        collectionView.rx.setDelegate(self).disposed(by: disposeBag)
        
        contentView.isUserInteractionEnabled = true
        
        addSubview(collectionView)
        addSubview(filmTitleLabel)
        addSubview(filmCountButton)
        addSubview(printedTitleLabel)
        
        filmTitleLabel.snp.makeConstraints {
            $0.left.equalTo(18)
            $0.top.equalTo(30)
        }
        
        filmCountButton.snp.makeConstraints {
            $0.width.equalTo(60)
            $0.height.equalTo(24)
            $0.right.equalTo(-35)
            $0.top.equalTo(31)
        }
        
        collectionView.snp.makeConstraints {
            $0.top.equalTo(filmTitleLabel.snp.bottom).offset(18)
            $0.height.equalTo(160)
            $0.left.right.equalTo(self)
        }
        
        printedTitleLabel.snp.makeConstraints {
            $0.left.equalTo(18)
            $0.top.equalTo(collectionView.snp.bottom).offset(30)
        }
    }
    
    private func bindViewModel(){
        let attribute = NSMutableAttributedString(string: "")
        let imageAttachment = NSTextAttachment()
        imageAttachment.image = UIImage(named: "point")
        attribute.append(attribute)

        /// set CollectionView DataSource
        viewModel.output.films
            .bind(to: collectionView.rx.items(cellIdentifier: FilmMainCollectionViewCell.reuseIdentifier, cellType: FilmMainCollectionViewCell.self)) { index, item, cell in
                cell.bindItem(film: item)
            }
            .disposed(by: disposeBag)
        
        viewModel.output.films
            .map { $0.map { $0.filmUid } }
            .map { "총 \($0.count - 1)개" }
            .asDriver(onErrorJustReturn: "")
            .drive(filmCountButton.rx.title(for: .normal))
            .disposed(by: disposeBag)
        
        collectionView.rx.modelSelected(Film.self)
            .subscribe(onNext: { film in
                if film.filmState != .create {
                    self.delegate?.presentDetailVC(viewModel: film)
                } else {
                    self.delegate?.presentCreateVC()
                }
            }).disposed(by: disposeBag)
        
        filmCountButton.rx.tap.bind { [weak self] in
            self?.delegate?.presentListVC()
        }.disposed(by: disposeBag)
    }
}
