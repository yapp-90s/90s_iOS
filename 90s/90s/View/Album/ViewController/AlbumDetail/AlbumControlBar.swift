//
//  AlbumControlBar.swift
//  90s
//
//  Created by 김진우 on 2022/01/02.
//

import UIKit

final class AlbumControlBar: UIView {
    
    // MARK: - UI Component
    private lazy var collectionButton: UIButton = {
        let button = UIButton()
        button.setImage(.init(named: "Icon_Listview_W"), for: .normal)
        addSubview(button)
        return button
    }()
    
    private lazy var label: UILabel = {
        let label = UILabel()
        label.font = .smallText
        label.textColor = .white
        addSubview(label)
        return label
    }()
    
    private lazy var completeButton: UIButton = {
        let button = UIButton()
        button.layer.cornerRadius = 18 * layoutScale
        button.backgroundColor = .Cool_Lightgray
        button.setTitle("완성하기", for: .normal)
        button.titleLabel?.font = .smallTextBold
        button.setTitleColor(.white, for: .normal)
        addSubview(button)
        return button
    }()
    
    // MARK: - Init
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        commonInit()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - Private Method
    private func commonInit() {
        setupUI()
    }
    
    private func setupUI() {
        backgroundColor = .Cool_Gray
        collectionButton.snp.makeConstraints {
            $0.width.height.equalTo(38 * layoutScale)
            $0.top.leading.equalToSuperview().offset(18 * layoutScale)
        }
        
        label.snp.makeConstraints {
            $0.width.equalTo(60 * layoutScale)
            $0.height.equalTo(18 * layoutScale)
            $0.top.equalTo(25 * layoutScale)
            $0.centerX.equalToSuperview()
        }
        
        completeButton.snp.makeConstraints {
            $0.width.equalTo(78 * layoutScale)
            $0.height.equalTo(36 * layoutScale)
            $0.top.equalToSuperview().offset(19 * layoutScale)
            $0.trailing.equalToSuperview().offset(-18 * layoutScale)
        }
    }
}
