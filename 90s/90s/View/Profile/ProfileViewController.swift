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
        iv.layer.cornerRadius = 10
        return iv
    }()
    
    private var nameLabel : UILabel = {
        return LabelType.bold_16.create()
    }()
    
    private var emailLabel : UILabel = {
        return LabelType.normal_13.create()
    }()
    
    private var informationView : UIView = {
        return UIView(frame: .zero)
    }()
    
    private var countLabel : UILabel = {
        return LabelType.normal_21.create()
    }()
    
    private var countInfoLabel: UILabel = {
        return LabelType.normal_gray_16.create()
    }()
  
    private var tableView: UITableView = {
        let tv = UITableView(frame: .zero)
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
        view.addSubview(profileView)
        view.addSubview(informationView)
        view.addSubview(tableView)
        
        profileView.addSubview(imageView)
        profileView.addSubview(nameLabel)
        profileView.addSubview(emailLabel)
        
        
        profileView.snp.makeConstraints {
            $0.top.left.right.equalToSuperview()
            $0.height.equalTo(160)
        }
        
        informationView.snp.makeConstraints {
            $0.top.left.right.equalToSuperview()
            $0.height.equalTo(110)
        }
        
        // Setting ProfileView
        
        imageView.snp.makeConstraints {
            $0.top.equalTo(13)
            $0.centerX.equalTo(view.snp.centerX)
            $0.width.height.equalTo(78)
        }
        
        nameLabel.snp.makeConstraints {
            $0.top.equalTo(12)
            $0.centerX.equalTo(view.snp.centerX)
        }
        
        emailLabel.snp.makeConstraints {
            $0.top.equalTo(5)
            $0.centerX.equalTo(view.snp.centerX)
        }
        
        // Setting informationView
        
        // Setting tableView
        
        tableView.snp.makeConstraints {
            $0.top.equalTo(6)
            $0.left.right.bottom.equalToSuperview()
        }
    }
}
