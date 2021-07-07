//
//  ProfileMainTableViewCell.swift
//  90s
//
//  Created by 성다연 on 2021/07/06.
//

import UIKit
import SnapKit

class ProfileMainTableViewCell: UITableViewCell {
    private var titleLabel : UILabel = {
        let label = LabelType.normal_16.create()
        return label
    }()
    
    private var nextButton : UIButton = {
        let button = UIButton(frame: .zero)
        button.setImage(UIImage(named: "point"), for: .normal)
        return button
    }()
    
    static let cellID = "ProfileMainTableViewCell"

    override func awakeFromNib() {
        super.awakeFromNib()
        setUpSubviews()
    }
    
    private func setUpSubviews(){
        addSubview(titleLabel)
        addSubview(nextButton)
        
        titleLabel.snp.makeConstraints {
            $0.left.equalToSuperview()
            $0.centerY.equalTo(contentView.snp.centerY)
        }
        
        nextButton.snp.makeConstraints {
            $0.right.equalToSuperview()
            $0.width.height.equalTo(50)
            $0.centerY.equalTo(contentView.snp.centerY)
        }
    }
}
