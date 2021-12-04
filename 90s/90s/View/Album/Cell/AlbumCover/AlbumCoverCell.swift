//
//  AlbumCoverCell.swift
//  90s
//
//  Created by 김진우 on 2021/11/20.
//

import UIKit

import RxSwift
import RxCocoa
import SnapKit

final class AlbumCoverCell: UICollectionViewCell {
    
    static let identifier = "AlbumCoverCell"
    
    var viewModel: AlbumCoverCellViewModel? {
        didSet {
            if let viewModel = viewModel {
                bindState(viewModel)
                bindAction(viewModel)
            }
        }
    }
    private var disposeBag = DisposeBag()
    
    private lazy var imageView: UIImageView = {
        let imageView = UIImageView()
        contentView.addSubview(imageView)
        return imageView
    }()
    
    private lazy var checkIcon: UIImageView = {
        let imageView = UIImageView()
        contentView.addSubview(imageView)
        imageView.image = .init(named: "Checkbox_Edit_Inact")
        return imageView
    }()
    
    private lazy var titleLabel: UILabel = {
        let label = UILabel()
        label.font = .Medium_Text_Bold
        label.textColor = .lightGray
        contentView.addSubview(label)
        return label
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        commonInit()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func commonInit() {
        setupUI()
    }
    
    private func setupUI() {
        imageView.snp.makeConstraints {
            $0.width.equalTo(imageView.snp.height)
            $0.top.leading.trailing.equalToSuperview()
        }
        
        checkIcon.snp.makeConstraints {
            $0.width.height.equalTo(34)
            $0.top.equalToSuperview().offset(6)
            $0.trailing.equalToSuperview().offset(-6)
        }
        
        titleLabel.snp.makeConstraints {
            $0.height.equalTo(20 * layoutScale)
            $0.leading.bottom.trailing.equalToSuperview()
        }
    }
    
    private func bindState(_ viewModel: AlbumCoverCellViewModel) {
        viewModel.output.albumViewModel.cover
            .map { $0?.image }
            .bind(to: imageView.rx.image)
            .disposed(by: disposeBag)
        
        viewModel.output.albumViewModel.name
            .bind(to: titleLabel.rx.text)
            .disposed(by: disposeBag)
        
        viewModel.output.isEdit
            .map { !$0 }
            .bind(to: checkIcon.rx.isHidden)
            .disposed(by: disposeBag)
        
        viewModel.output.isSelected
            .map { $0 ? UIImage(named: "Checkbox_Edit_Act") : .init(named: "Checkbox_Edit_Inact") }
            .bind(to: checkIcon.rx.image)
            .disposed(by: disposeBag)
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
        
        disposeBag = DisposeBag()
    }
    
    private func bindAction(_ viewModel: AlbumCoverCellViewModel) {
        
    }
}

