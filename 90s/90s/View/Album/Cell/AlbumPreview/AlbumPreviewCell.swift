//
//  AlbumPreviewCollectionViewCell.swift
//  90s
//
//  Created by 김진우 on 2021/03/27.
//

import UIKit
import RxSwift
import RxCocoa
import Kingfisher

class AlbumPreviewViewCell: UICollectionViewCell {
    
    static let identifier = "AlbumPreviewViewCell"
    
    let disposeBag = DisposeBag()
    
    lazy private(set) var coverImageView: UIImageView = {
        let imageView = UIImageView()
        self.addSubview(imageView)
        return imageView
    }()
    
    lazy var dateLabel: UILabel = {
        let label = UILabel()
        label.font = .smallText
        label.textColor = .gray
        self.addSubview(label)
        return label
    }()
    
    lazy var nameLabel: UILabel = {
        let label = UILabel()
        label.font = .inputText
        self.addSubview(label)
        return label
    }()
    
    lazy var button: UIButton = {
        let button = UIButton()
        button.isUserInteractionEnabled = false
        button.setImage(.init(named: "albumMore"), for: .normal)
        self.addSubview(button)
        return button
    }()
    
    lazy var imageStackView: UIStackView = {
        let stackView = UIStackView()
        stackView.axis = .horizontal
        stackView.spacing = 6 * layoutScale
        stackView.distribution = .fillEqually
        self.addSubview(stackView)
        return stackView
    }()
    
    // MARK: - Init
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
        coverImageView.snp.makeConstraints {
            $0.top.equalToSuperview().offset(10 * layoutScale)
            $0.left.equalToSuperview()
            $0.width.height.equalTo(52 * layoutScale)
        }
        
        dateLabel.snp.makeConstraints {
            $0.height.equalTo(14 * layoutScale)
            $0.left.equalTo(coverImageView.snp.right).offset(12 * layoutScale)
            $0.top.equalToSuperview().offset(18 * layoutScale)
        }
        
        nameLabel.snp.makeConstraints {
            $0.height.equalTo(18 * layoutScale)
            $0.left.equalTo(coverImageView.snp.right).offset(12 * layoutScale)
            $0.top.equalTo(dateLabel.snp.bottom).offset(4 * layoutScale)
        }
        
        button.snp.makeConstraints {
            $0.width.height.equalTo(37 * layoutScale)
            $0.top.equalToSuperview().offset(17 * layoutScale)
            $0.right.equalToSuperview()
            $0.left.equalTo(dateLabel.snp.right).offset(12 * layoutScale)
            $0.left.equalTo(nameLabel.snp.right).offset(12 * layoutScale)
        }
        
        imageStackView.snp.makeConstraints {
            $0.top.equalTo(coverImageView.snp.bottom).offset(6 * layoutScale)
            $0.left.equalToSuperview()
            $0.right.equalToSuperview()
            $0.bottom.equalToSuperview().offset(-10 * layoutScale)
        }
    }
    
    func bind(viewModel: AlbumPreviewCellViewModel) {
        nameLabel.text = viewModel.output.name
        
        coverImageView.image = viewModel.output.image
        
        dateLabel.text = viewModel.output.dateString
        
        DispatchQueue.main.async {
            var count = 0
            self.imageStackView.subviews.forEach { subView in
                self.imageStackView.removeArrangedSubview(subView)
                subView.removeFromSuperview()
            }
            for photo in viewModel.output.photos {
                count += 1
                let imageView = UIImageView()
                imageView.clipsToBounds = true
                imageView.contentMode = .scaleAspectFill
                imageView.kf.setImage(with: URL(string: photo.url))
                self.imageStackView.addArrangedSubview(imageView)
                if count >= 5 {
                    break
                }
            }
        }
    }
}
