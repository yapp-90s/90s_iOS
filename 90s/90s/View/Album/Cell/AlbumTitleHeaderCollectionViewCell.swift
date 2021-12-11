//
//  AlbumTitleHeaderCollectionViewCell.swift
//  90s
//
//  Created by 김진우 on 2021/04/04.
//

import UIKit
import SnapKit

protocol AlbumTitleHeaderCellDelegate: AnyObject {
    func touchButton()
}

class AlbumTitleHeaderCollectionViewCell: UICollectionViewCell {
        
    static let identifier = "AlbumTitleHeaderCollectionViewCell"
    
    weak var delegate: AlbumTitleHeaderCellDelegate?
    
    var isButtton: Bool = false {
        didSet {
            button.isHidden = !isButtton
        }
    }
    
    lazy var label: UILabel = {
        let label = UILabel()
        label.font = .Head
        label.text = "만드는 중!"
        label.textColor = .white
        self.addSubview(label)
        return label
    }()
    
    lazy var button: UIButton = {
        let button = UIButton()
        button.semanticContentAttribute = .forceRightToLeft
        button.imageEdgeInsets = .init(top: 0, left: 13 * layoutScale, bottom: 0, right: 0)
        button.setImage(.init(named: "show_arrow"), for: .normal)
        button.setTitle("총 00개", for: .normal)
        button.setTitleColor(.gray, for: .normal)
        button.isHidden = true
        self.addSubview(button)
        return button
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
        
        button.addTarget(self, action: #selector(buttonAction), for: .touchUpInside)
    }
    
    private func setupUI() {
        label.snp.makeConstraints {
            $0.height.equalTo(24)
            $0.top.equalToSuperview().offset(12)
            $0.left.equalToSuperview().offset(18)
            $0.right.equalToSuperview().offset(-18)
            $0.bottom.equalToSuperview().offset(-12)
        }
        
        button.snp.makeConstraints {
            $0.height.equalTo(24 * layoutScale)
            $0.trailing.equalToSuperview().offset(-18)
            $0.centerY.equalToSuperview()
        }
    }
    
    @objc func buttonAction() {
        delegate?.touchButton()
    }
}
