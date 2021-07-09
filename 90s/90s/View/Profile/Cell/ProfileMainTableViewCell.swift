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
        let label = LabelType.normal_16.create()
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
    
    static let cellID = "ProfileMainTableViewCell"

    override func awakeFromNib() {
        super.awakeFromNib()
        setUpSubviews()
    }
    
    private func setUpSubviews(){
        addSubview(titleLabel)
        addSubview(pointView)
        addSubview(nextImageView)
        addSubview(spacingView)
        
        contentView.backgroundColor = .colorRGBHex(hex: 0x222225)
        
        titleLabel.snp.makeConstraints {
            $0.left.equalToSuperview()
            $0.centerY.equalTo(contentView.snp.centerY)
        }
        
        pointView.snp.makeConstraints {
            $0.width.height.equalTo(4)
            $0.left.equalTo(titleLabel.snp.right).offset(3)
            $0.top.equalTo(titleLabel.snp.top)
        }
        
        nextImageView.snp.makeConstraints {
            $0.right.equalToSuperview()
            $0.width.height.equalTo(50)
            $0.centerY.equalTo(contentView.snp.centerY)
        }
        
        spacingView.snp.makeConstraints {
            $0.height.equalTo(8)
            $0.left.right.bottom.equalToSuperview()
        }
    }
}
