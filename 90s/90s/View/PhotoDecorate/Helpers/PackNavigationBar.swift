//
//  PackNavigationBar.swift
//  90s
//
//  Created by woong on 2021/03/06.
//

import UIKit

class PackNavigationBar: UIView {
    
    enum SideViewPosition {
        case left
        case right
    }

    let titleLabel: UILabel = {
        let label = UILabel()
        label.text = "스티커팩이름"
        label.textAlignment = .center
        return label
    }()
    
    private let leftStackView: UIStackView = {
        let stackView = UIStackView()
        
        return stackView
    }()
    
    private let rightStackView: UIStackView = {
        let stackView = UIStackView()
        
        return stackView
    }()
    
    func addSideView(_ sideView: UIView, to position: SideViewPosition) {
        switch position {
            case .left:
                leftStackView.addArrangedSubview(sideView)
            case .right:
                rightStackView.addArrangedSubview(sideView)
        }
    }
    
    // MARK: - Intialize
    
    init() {
        super.init(frame: .zero)
        setupViews()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setupViews() {
        addSubview(titleLabel)
        addSubview(leftStackView)
        addSubview(rightStackView)
        
        titleLabel.snp.makeConstraints {
            $0.center.equalToSuperview()
            $0.width.equalTo(150)
        }
        
        leftStackView.snp.makeConstraints {
            $0.centerY.equalToSuperview()
            $0.leading.equalToSuperview().inset(20)
            $0.trailing.lessThanOrEqualTo(titleLabel.snp.leading)
            $0.top.bottom.greaterThanOrEqualToSuperview()
        }
        
        rightStackView.snp.makeConstraints {
            $0.centerY.equalToSuperview()
            $0.trailing.equalToSuperview().inset(-20)
            $0.leading.greaterThanOrEqualTo(titleLabel.snp.trailing)
            $0.top.bottom.greaterThanOrEqualToSuperview()
        }
    }
}
