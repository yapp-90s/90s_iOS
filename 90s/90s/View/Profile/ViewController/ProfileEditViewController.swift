//
//  ProfileEditViewController.swift
//  90s
//
//  Created by 성다연 on 2021/07/02.
//

import UIKit

class ProfileEditViewController: UIViewController {
    
    private var profileImageView : UIImageView = {
        let iv = UIImageView(frame: .zero)
        iv.clipsToBounds = true
        iv.layer.cornerRadius = 38
        return iv
    }()
    
    private var nameTextField : UITextField = {
        let tf = UITextField(frame: .zero)
        return tf
    }()
    
    private var underLineLabel : UILabel = {
        let label = UILabel(frame: .zero)
        label.backgroundColor = .lightGray
        return label
    }()
    
    private var editButton : UIButton = {
        let button = UIButton(frame: .zero)
        button.setTitle("수정하기", for: .normal)
        button.backgroundColor = .colorRGBHex(hex: 0x2E2F33)
        button.clipsToBounds = true
        button.layer.cornerRadius = 5
        return button
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setUpSubviews()
    }
    
    private func setUpSubviews() {
        view.addSubview(profileImageView)
        view.addSubview(nameTextField)
        view.addSubview(underLineLabel)
        view.addSubview(editButton)
    
        profileImageView.snp.makeConstraints {
            $0.top.equalTo(13)
            $0.height.width.equalTo(78)
            $0.centerX.equalTo(view.snp.centerX)
        }
        
        nameTextField.snp.makeConstraints {
            $0.centerX.equalTo(view.snp.centerX)
            $0.top.equalTo(profileImageView.snp.bottom).offset(35)
        }
        
        underLineLabel.snp.makeConstraints {
            $0.centerX.equalTo(view.snp.centerX)
            $0.top.equalTo(nameTextField.snp.bottom).offset(10)
        }
        
        editButton.snp.makeConstraints {
            $0.top.equalTo(nameTextField.snp.bottom).offset(35)
            $0.height.equalTo(60)
            $0.centerX.equalTo(view.snp.centerX)
        }
    }
}
