//
//  ProfileSettingTableViewCell.swift
//  90s
//
//  Created by 성다연 on 2021/07/08.
//

import UIKit
import SnapKit

class ProfileSettingTableViewCell: UITableViewCell {
    let titleLabel : UILabel = {
        let label = LabelType.normal_16.create()
        label.text = "Title"
        return label
    }()
    
    private let switchButton : UISwitch = {
        let sbutton = UISwitch(frame: .zero)
        return sbutton
    }()
    
    private let spacingView : UIView = {
        let view = UIView(frame: .zero)
        view.backgroundColor = .black
        return view
    }()
    
    static let cellID = "ProfileSettingTableViewCell"

    override func awakeFromNib() {
        super.awakeFromNib()
        setUpSubviews()
    }

    private func setUpSubviews() {
        addSubview(titleLabel)
        addSubview(switchButton)
        addSubview(spacingView)
        
        titleLabel.snp.makeConstraints {
            $0.centerY.equalTo(contentView.snp.centerY)
            $0.left.equalTo(contentView.safeAreaLayoutGuide).offset(8)
        }
        
        switchButton.snp.makeConstraints {
            $0.centerY.equalTo(contentView.snp.centerY)
            $0.right.equalTo(contentView.snp.right).offset(-8)
        }
        
        spacingView.snp.makeConstraints {
            $0.height.equalTo(8)
            $0.left.right.bottom.equalToSuperview()
        }
    }
    
    func bindViewModel(name: String, isExist: Bool, isClicked: Bool) {
        titleLabel.text = name
        switchButton.setOn(isClicked, animated: true)
    }
}
