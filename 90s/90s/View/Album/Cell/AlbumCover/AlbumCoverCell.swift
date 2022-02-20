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
        label.font = .mediumTextBold
        label.textColor = .lightGray
        contentView.addSubview(label)
        return label
    }()
    
    var viewModel: AlbumCoverCellViewModel? {
        didSet {
            if let viewModel = viewModel {
                bindState(viewModel)
                bindAction(viewModel)
            }
        }
    }
    private var disposeBag = DisposeBag()
    
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
        imageView.image = viewModel.output.albumViewModel.album.cover.image
        titleLabel.text = viewModel.output.albumViewModel.album.name
        checkIcon.isHidden = !viewModel.output.isEdit
        checkIcon.image = viewModel.output.iconImage
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
        
        imageView.image = nil
        titleLabel.text = nil
        viewModel = nil
    }
    
    private func bindAction(_ viewModel: AlbumCoverCellViewModel) {
        
    }
}

