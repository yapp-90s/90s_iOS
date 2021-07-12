//
//  ProfileSettingViewController.swift
//  90s
//
//  Created by 성다연 on 2021/07/02.
//

import UIKit
import SnapKit
import RxSwift

final class ProfileSettingViewController: BaseViewController, UIScrollViewDelegate {
    private var tableView : UITableView = {
        let tv = UITableView(frame: .zero)
        tv.isScrollEnabled = false
        tv.showsVerticalScrollIndicator = false
        tv.separatorStyle = .none
        tv.rowHeight = 70
        
        tv.register(ProfileSettingTableViewCell.self, forCellReuseIdentifier: ProfileSettingTableViewCell.cellID)
        return tv
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
    
    private let signoutButton : UIButton = {
        let button = UIButton(frame: .zero)
        button.setTitle("회원탈퇴", for: .normal)
        button.tintColor = .gray
        button.titleLabel?.font = .systemFont(ofSize: 14)
        return button
    }()
    
    private var items : [(String, Bool, Bool)] = [
        ("마케팅 이벤트 알림", true, true),
        ("인화 알림", true, false),
        ("로그아웃", false, false)
    ]

    override func viewDidLoad() {
        super.viewDidLoad()
        setUpSubviews()
        setUpTableView()
    }
 
    private func setUpSubviews() {
        navigationItem.title = "설정"
        
        view.addSubview(tableView)
        view.addSubview(signoutButton)
        view.addSubview(leaveView)
        
        leaveView.addSubview(leaveTitleLabel)
        leaveView.addSubview(leaveSubTitleLabel)
        leaveView.addSubview(notLeaveButton)
        leaveView.addSubview(leaveButton)
        
        tableView.snp.makeConstraints {
            $0.edges.equalTo(view.safeAreaLayoutGuide)
        }
        
        signoutButton.snp.makeConstraints {
            $0.height.equalTo(60)
            $0.left.right.bottom.equalTo(view.safeAreaLayoutGuide)
        }
    }
    
    private func setUpTableView() {
        tableView.rx.setDelegate(self).disposed(by: disposeBag)
        
        Observable.just(items).bind(to: tableView.rx.items(cellIdentifier: ProfileSettingTableViewCell.cellID, cellType: ProfileSettingTableViewCell.self)) { index, element, cell in
            cell.titleLabel.text = element.0
            cell.bindViewModel(name: element.0, isExist: element.1, isClicked: element.2)
        }.disposed(by: disposeBag)
    }
}
