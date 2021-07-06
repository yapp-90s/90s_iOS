//
//  ProfileViewController.swift
//  90s
//
//  Created by 성다연 on 2021/06/28.
//

import UIKit
import SnapKit

class ProfileViewController: UIViewController {

    // MARK: - UI Component
    
    private var profileView : UIView = {
        let v = UIView(frame: .zero)
        return v
    }()
    
    private let imageView : UIImageView = {
        let iv = UIImageView(frame: .zero)
        iv.clipsToBounds = true
        iv.layer.cornerRadius = 38
        iv.backgroundColor = .gray
        return iv
    }()
    
    private var nameLabel : UILabel = {
        let label = LabelType.bold_16.create()
        label.text = "User Name"
        return label
    }()
    
    private var emailLabel : UILabel = {
        let label = LabelType.normal_13.create()
        label.text = "aaaabbbb@90s.com"
        return label
    }()
    
    private var informationView : UIView = {
        let v = UIView(frame: .zero)
        return v
    }()
    
    private var countLabel : UILabel = {
        let label = LabelType.normal_21.create()
        return label
    }()
    
    private var countInfoLabel: UILabel = {
        let label = LabelType.normal_gray_16.create()
        return label
    }()
  
    private var tableView: UITableView = {
        let tv = UITableView(frame: .zero)
        tv.backgroundColor = .Warm_Gray
        return tv
    }()
    
    private var manageButton: UIButton = {
        let btn = UIButton(frame: .zero)
        btn.tintColor = .gray
        return btn
    }()
    
    private var pointView : UIView = {
        let v = UIView(frame: CGRect(x: 0, y: 0, width: 4, height: 4))
        v.backgroundColor = .retroOrange
        v.clipsToBounds = true
        v.layer.cornerRadius = 1
        return v
    }()
    
    // MARK: - LifeCycle

    override func viewDidLoad() {
        super.viewDidLoad()
        setUpSubviews()
    }
    
    
    private func setUpSubviews() {
        view.backgroundColor = .black
        
        view.addSubview(profileView)
        view.addSubview(informationView)
        view.addSubview(tableView)
        
        profileView.addSubview(imageView)
        profileView.addSubview(nameLabel)
        profileView.addSubview(emailLabel)
        
        let safe = view.safeAreaLayoutGuide
        
        profileView.snp.makeConstraints {
            $0.top.left.right.equalTo(safe)
            $0.height.equalTo(160)
        }
        
        informationView.snp.makeConstraints {
            $0.top.equalTo(profileView.snp.bottom).offset(11)
            $0.left.right.equalToSuperview()
            $0.height.equalTo(110)
        }
        
        // Setting ProfileView
        
        imageView.snp.makeConstraints {
            $0.top.equalTo(13)
            $0.centerX.equalTo(view.snp.centerX)
            $0.width.height.equalTo(78)
        }
        
        nameLabel.snp.makeConstraints {
            $0.top.equalTo(imageView.snp.bottom).offset(12)
            $0.centerX.equalTo(view.snp.centerX)
        }
        
        emailLabel.snp.makeConstraints {
            $0.top.equalTo(nameLabel.snp.bottom).offset(5)
            $0.centerX.equalTo(view.snp.centerX)
        }
        
        // Setting informationView
        
        // Setting tableView
        
        tableView.snp.makeConstraints {
            $0.top.equalTo(informationView.snp.bottom).offset(6)
            $0.left.right.bottom.equalToSuperview()
        }
    }
}
