//
//  AlbumCreateCollectionViewCell.swift
//  90s
//
//  Created by 김진우 on 2021/04/03.
//

import UIKit
import RxCocoa
import RxSwift
import SnapKit

class AlbumCreateCollectionViewCell: UICollectionViewCell {
    
    static let identifier = "AlbumCreateCollectionViewCell"
    let disposeBag = DisposeBag()
    
    lazy private(set) var titleLabel: UILabel = {
        let label = UILabel()
        label.numberOfLines = 2
        label.text = "아날로그 감성 듬뿍 담아\n만드는 나만의 앨범"
        label.font = .subHead
        label.textColor = .white
        self.addSubview(label)
        return label
    }()
    
    lazy var createButton: UIButton = {
        let button = UIButton()
        button.isUserInteractionEnabled = false
        button.backgroundColor = .retroOrange
        button.setTitleColor(.white, for: .normal)
        button.setTitle("앨범 만들기", for: .normal)
        button.titleLabel?.font = .buttonText
        button.layer.cornerRadius = 6
        self.addSubview(button)
        return button
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        commonInit()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        
        commonInit()
    }
    
    private func commonInit() {
        setupUI()
    }
    
    private func setupUI() {
        titleLabel.snp.makeConstraints {
            $0.height.equalTo(46 * layoutScale)
            $0.top.equalToSuperview().offset(21 * layoutScale)
            $0.left.equalToSuperview().offset(18 * layoutScale)
            $0.bottom.equalToSuperview().offset(-21 * layoutScale)
        }
        
        createButton.snp.makeConstraints {
            $0.width.equalTo(115 * layoutScale)
            $0.height.equalTo(48 * layoutScale)
            $0.top.equalToSuperview().offset(20 * layoutScale)
            $0.right.equalToSuperview().offset(-18 * layoutScale)
            $0.left.equalTo(titleLabel.snp.right)
            $0.bottom.equalToSuperview().offset(-20 * layoutScale)
        }
    }
    
    func bind(viewModel: AlbumCreateCellViewModel) {
        createButton.rx.tap
            .bind(to: viewModel.createAlbum)
            .disposed(by: disposeBag)
    }
}
