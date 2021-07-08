//
//  ProfileSettingTableViewCell.swift
//  90s
//
//  Created by 성다연 on 2021/07/08.
//

import UIKit
import SnapKit

class ProfileSettingTableViewCell: UITableViewCell {
    private var titleLabel : UILabel = {
        return LabelType.normal_16.create()
    }()
    
    private var switchButton : UISwitch = {
        let sbutton = UISwitch(frame: .zero)
        return sbutton
    }()
    
    private let leaveView : UIView = {
        let view = UIView(frame: .zero)
        view.clipsToBounds = true
        view.layer.cornerRadius = 8
        view.backgroundColor = .Cool_Gray
        return view
    }()
    
    private let leaveTitleLabel : UILabel = {
        let label = LabelType.bold_18.create()
        label.text = "정말 떠나실 건가요?"
        return label
    }()
    
    private let leaveSubTitleLabel : UILabel = {
        let label = LabelType.normal_gray_13.create()
        return label
    }()
    
    private let notLeaveButton : UIButton = {
        let button = UIButton(frame: .zero)
        button.clipsToBounds = true
        button.layer.cornerRadius = 5
        button.setTitle("다시 생각해 볼게요", for: .normal)
        button.backgroundColor = .retroOrange
        return button
    }()
    
    private let leaveButton : UIButton = {
        let button = UIButton(frame: .zero)
        button.clipsToBounds = true
        button.layer.cornerRadius = 5
        button.setTitle("회원 탈퇴", for: .normal)
        button.backgroundColor = .Cool_Lightgray
        return button
    }()

    override func awakeFromNib() {
        super.awakeFromNib()
        setUpSubviews()
    }

    private func setUpSubviews() {
        addSubview(titleLabel)
        addSubview(switchButton)
        addSubview(leaveView)
        
        leaveView.addSubview(leaveTitleLabel)
        leaveView.addSubview(leaveSubTitleLabel)
        leaveView.addSubview(notLeaveButton)
        leaveView.addSubview(leaveButton)
        
        
        titleLabel.snp.makeConstraints {
            $0.centerY.equalTo(contentView.snp.centerY)
            $0.left.equalTo(contentView.safeAreaLayoutGuide).offset(8)
        }
        
        switchButton.snp.makeConstraints {
            $0.centerY.equalTo(contentView.snp.centerY)
            $0.right.equalTo(contentView.snp.right).offset(-8)
        }
        
        // -TODO: Need To Set Leave View Constraint
        
        
    }
    
    func bindViewModel(name: String, isClicked: Bool) {
        titleLabel.text = name
        switchButton.setOn(isClicked, animated: true)
    }
}
