//
//  AlbumTitleHeaderCollectionViewCell.swift
//  90s
//
//  Created by 김진우 on 2021/04/04.
//

import UIKit
import SnapKit

class AlbumTitleHeaderCollectionViewCell: UICollectionViewCell {
        
    static let identifier = "AlbumTitleHeaderCollectionViewCell"
    
    lazy var label: UILabel = {
        let label = UILabel()
        label.font = .Head
        label.text = "만드는 중!"
        label.textColor = .white
        self.addSubview(label)
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
        label.snp.makeConstraints {
            $0.height.equalTo(24 * layoutScale)
            $0.top.equalToSuperview().offset(12 * layoutScale)
            $0.left.equalToSuperview().offset(18 * layoutScale)
            $0.right.equalToSuperview().offset(-18 * layoutScale)
            $0.bottom.equalToSuperview().offset(-12 * layoutScale)
        }
    }
}
