//
//  ProfileSettingTableViewCell.swift
//  90s
//
//  Created by 성다연 on 2021/07/08.
//

import UIKit
import SnapKit

class ProfileSettingTableViewCell: UITableViewCell {
    private let titleLabel : UILabel = {
        let label = LabelType.normal_16.create()
        label.text = "Title"
        return label
    }()
    
    private var switchButton : UISwitch = {
        let sbutton = UISwitch(frame: .zero)
        return sbutton
    }()
    
    private let spacingView : UIView = {
        let view = UIView(frame: .zero)
        view.backgroundColor = .black
        return view
    }()
    
    static let cellID = "ProfileSettingTableViewCell"

    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setUpSubviews()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setUpSubviews() {
        addSubview(titleLabel)
        addSubview(switchButton)
        addSubview(spacingView)
        
        backgroundColor = .colorRGBHex(hex: 0x222225)
        
        titleLabel.snp.makeConstraints {
            $0.centerY.equalTo(contentView.snp.centerY).offset(-2)
            $0.left.equalTo(contentView.safeAreaLayoutGuide).offset(8)
        }
        
        switchButton.snp.makeConstraints {
            $0.centerY.equalTo(contentView.snp.centerY).offset(-2)
            $0.right.equalTo(contentView.snp.right).offset(-18)
        }
        
        spacingView.snp.makeConstraints {
            $0.height.equalTo(4)
            $0.left.right.bottom.equalToSuperview()
        }
    }
    
    func bindViewModel(name: String, isExist: Bool, isClicked: Bool) {
        titleLabel.text = name
        switchButton.isHidden = !isExist
        if isExist {
            switchButton.setOn(isClicked, animated: true)
        }
    }
}
