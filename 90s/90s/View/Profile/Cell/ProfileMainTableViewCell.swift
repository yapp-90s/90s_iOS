//
//  ProfileMainTableViewCell.swift
//  90s
//
//  Created by 성다연 on 2021/07/06.
//

import UIKit
import SnapKit

class ProfileMainTableViewCell: UITableViewCell {
    
    private let titleLabel : UILabel = {
        let label = UILabel(frame: .zero)
        label.font = .Profile_Menu_Text
        label.text = "Title"
        return label
    }()
    
    private let pointView: UIView = {
        let view = UIView(frame: .zero)
        view.clipsToBounds = true
        view.layer.cornerRadius = 2
        view.backgroundColor = .retroOrange
        return view
    }()
    
    private let nextImageView : UIImageView = {
        let iv = UIImageView(frame: .zero)
        iv.image = UIImage(named: "point")
        return iv
    }()
    
    private let spacingView : UIView = {
        let view = UIView(frame: .zero)
        view.backgroundColor = .black
        return view
    }()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setUpSubviews()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setUpSubviews() {
        addSubview(titleLabel)
        addSubview(pointView)
        addSubview(nextImageView)
        addSubview(spacingView)
        
        backgroundColor = .colorRGBHex(hex: 0x222225)
        
        titleLabel.snp.makeConstraints {
            $0.left.equalTo(18)
            $0.centerY.equalTo(contentView.snp.centerY).offset(-2)
        }
        
        pointView.snp.makeConstraints {
            $0.width.height.equalTo(4)
            $0.left.equalTo(titleLabel.snp.right).offset(3)
            $0.top.equalTo(titleLabel.snp.top)
        }
        
        nextImageView.snp.makeConstraints {
            $0.right.equalTo(-24)
            $0.height.equalTo(13)
            $0.width.equalTo(6)
            $0.centerY.equalTo(contentView.snp.centerY).offset(-2)
        }
        
        spacingView.snp.makeConstraints {
            $0.height.equalTo(4)
            $0.left.right.bottom.equalToSuperview()
        }
    }
    
    func configure(title: String, isUpdated: Bool = false) {
        titleLabel.text = title
        pointView.isHidden = !isUpdated
    }
}
