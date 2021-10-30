//
//  IntroCollectionViewCell.swift
//  90s
//
//  Created by woongs on 2021/10/04.
//

import UIKit

class IntroCollectionViewCell: UICollectionViewCell {
    
    struct IntroContents {
        var title: String
        var subTitle: String
        var imageName: String
    }
    
    fileprivate var titleLabel: UILabel = {
        let label = UILabel()
        label.font = .Head
        label.textColor = .white
        label.numberOfLines = 0
        label.textAlignment = .center
        label.setContentHuggingPriority(.defaultHigh, for: .vertical)
        return label
    }()
    
    fileprivate var subTitleLabel: UILabel = {
        let label = UILabel()
        label.font = .Medium_Text
        label.textColor = .init(hexString: "9E9EA3")
        label.numberOfLines = 0
        label.textAlignment = .center
        label.setContentHuggingPriority(.defaultHigh, for: .vertical)
        return label
    }()
    
    fileprivate var imageView: UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFit
        return imageView
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.setupViews()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func configure(contents: IntroContents) {
        self.titleLabel.text = contents.title
        self.subTitleLabel.text = contents.subTitle
        self.imageView.image = UIImage(named: contents.imageName)
    }
    
    private func setupViews() {
        self.addSubview(self.titleLabel)
        self.addSubview(self.subTitleLabel)
        self.addSubview(self.imageView)
        
        self.titleLabel.snp.makeConstraints { maker in
            maker.top.equalToSuperview().inset(42)
            maker.centerX.equalToSuperview()
        }
        
        self.subTitleLabel.snp.makeConstraints { maker in
            maker.top.equalTo(self.titleLabel.snp.bottom).offset(16)
            maker.centerX.equalToSuperview()
        }
        
        self.imageView.snp.makeConstraints { maker in
            maker.top.equalTo(self.subTitleLabel.snp.bottom).offset(9)
            maker.leading.trailing.equalToSuperview().inset(30)
            maker.bottom.equalToSuperview().inset(14)
        }
    }
}
