//
//  ProfileSettingViewController.swift
//  90s
//
//  Created by 성다연 on 2021/07/02.
//

import UIKit
import SnapKit

class ProfileSettingViewController: UIViewController {
    private var tableView : UITableView = {
        let tv = UITableView(frame: .zero)
        return tv
    }()
    
    private let signoutButton : UIButton = {
        let button = UIButton(frame: .zero)
        button.setTitle("회원탈퇴", for: .normal)
        button.tintColor = .gray
        button.titleLabel?.font = .systemFont(ofSize: 14)
        return button
    }()

    override func viewDidLoad() {
        super.viewDidLoad()
        setUpSubviews()
        // Do any additional setup after loading the view.
    }
 
    private func setUpSubviews() {
        view.addSubview(tableView)
        view.addSubview(signoutButton)
        
        tableView.snp.makeConstraints {
            $0.edges.equalTo(view.safeAreaLayoutGuide)
        }
        
        signoutButton.snp.makeConstraints {
            $0.height.equalTo(60)
            $0.left.right.bottom.equalTo(view.safeAreaLayoutGuide)
        }
    }
}
