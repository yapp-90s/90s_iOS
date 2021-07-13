//
//  ProfileLeaveViewController.swift
//  90s
//
//  Created by 성다연 on 2021/07/12.
//

import UIKit
import SnapKit
import RxSwift
import RxCocoa

final class ProfileLeaveViewController: BaseViewController, UIScrollViewDelegate {
    
    private let closeButton : UIButton = {
        let button = UIButton(frame: .zero)
        button.setImage(UIImage(named: "navigationBar_close"), for: .normal)
        return button
    }()
    
    private let titleLabel : UILabel = {
        return UILabel.createSpacingLabel(text: "탈퇴를 결심한 이유는\n무엇인가요?", size: 17, numberOfLines: 2)
    }()
    
    private let tableView : UITableView = {
        let tv = UITableView(frame: .zero)
        tv.showsHorizontalScrollIndicator = false
        tv.separatorStyle = .none
        tv.rowHeight = 60
        tv.backgroundColor = .black
        
        tv.register(ProfileLeaveTableViewCell.self, forCellReuseIdentifier: ProfileLeaveTableViewCell.cellID)
        return tv
    }()
    
    private let leaveButton : UIButton = {
        let button = UIButton(frame: .zero)
        button.backgroundColor = .Cool_Gray
        button.setTitle("회원탈퇴", for: .normal)
        button.titleLabel?.font = .boldSystemFont(ofSize: 15)
        button.clipsToBounds = true
        button.layer.cornerRadius = 5
        button.isEnabled = false
        return button
    }()
    
    private var items = Observable.of([
        "사용하기 어려워요",
        "흥미가 없어졌어요",
        "오류가 많아서 불편해요",
        "기타"
    ])

    override func viewDidLoad() {
        super.viewDidLoad()
        setUpSubviews()
        setUpTableView()
        setUpButtonEvent()
    }
    
    private func setUpSubviews() {
        view.addSubview(closeButton)
        view.addSubview(titleLabel)
        view.addSubview(tableView)
        view.addSubview(leaveButton)
        
        view.backgroundColor = .black
        
        closeButton.snp.makeConstraints {
            $0.width.height.equalTo(50)
            $0.right.equalTo(-18)
            $0.top.equalTo(view.safeAreaLayoutGuide).offset(18)
        }
        
        titleLabel.snp.makeConstraints {
            $0.left.equalTo(18)
            $0.top.equalTo(closeButton).offset(47)
        }
        
        tableView.snp.makeConstraints {
            $0.left.right.equalToSuperview()
            $0.top.equalTo(titleLabel.snp.bottom).offset(30)
            $0.bottom.equalTo(leaveButton.snp.top)
        }
        
        leaveButton.snp.makeConstraints {
            $0.height.equalTo(57)
            $0.left.equalTo(18)
            $0.right.equalTo(-18)
            $0.bottom.equalTo(view.safeAreaLayoutGuide).offset(-250)
        }
    }
    
    private func setUpTableView() {
        tableView.rx.setDelegate(self).disposed(by: disposeBag)
        
        items.bind(to: tableView.rx.items(cellIdentifier: ProfileLeaveTableViewCell.cellID, cellType: ProfileLeaveTableViewCell.self)) { index, element, cell in
            cell.bindViewModel(text: element)
            cell.selectionStyle = .none
        }.disposed(by: disposeBag)
        
        tableView.rx.itemSelected
            .subscribe(onNext: { indexPath in
                let cell = self.tableView.cellForRow(at: indexPath) as! ProfileLeaveTableViewCell
                cell.changeImageView(isClicked: true)
                
                self.leaveButton.backgroundColor = .retroOrange
                self.leaveButton.isEnabled = true
            }).disposed(by: disposeBag)
        
        tableView.rx.itemDeselected
            .subscribe(onNext: { indexPath in
                let cell = self.tableView.cellForRow(at: indexPath) as! ProfileLeaveTableViewCell
                cell.changeImageView(isClicked: false)
                
                self.leaveButton.backgroundColor = .Cool_Gray
                self.leaveButton.isEnabled = false
            }).disposed(by: disposeBag)
    }
    
    private func setUpButtonEvent() {
        closeButton.rx.tap.bind {
            self.dismiss(animated: true)
        }.disposed(by: disposeBag)
        
        leaveButton.rx.tap.bind {
            self.dismiss(animated: true)
        }.disposed(by: disposeBag)
    }
}
