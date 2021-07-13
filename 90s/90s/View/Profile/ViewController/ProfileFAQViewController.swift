//
//  ProfileFAQViewController.swift
//  90s
//
//  Created by 성다연 on 2021/07/02.
//

import UIKit
import RxSwift

final class ProfileFAQViewController: BaseViewController, UIScrollViewDelegate {
    
    private let tableView : UITableView = {
        let tv = UITableView(frame: .zero)
        tv.separatorStyle = .none
        tv.rowHeight = 65
        tv.showsVerticalScrollIndicator = false
        
        tv.register(ProfileMainTableViewCell.self, forCellReuseIdentifier: ProfileMainTableViewCell.cellID)
        return tv
    }()
    
    
    private let items = Observable.of([
        "자주 묻는 질문 리스트 1",
        "자주 묻는 질문 리스트 2",
        "자주 묻는 질문 리스트 3"
    ])
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setUpSubviews()
        setUpTableView()
    }
    
    private func setUpSubviews() {
        navigationItem.title = "자주 묻는 질문"
        
        view.addSubview(tableView)
        
        tableView.snp.makeConstraints {
            $0.edges.equalTo(view.safeAreaLayoutGuide)
        }
    }
    
    private func setUpTableView() {
        tableView.rx.setDelegate(self).disposed(by: disposeBag)
        
        items.bind(to: tableView.rx.items(cellIdentifier: ProfileMainTableViewCell.cellID, cellType: ProfileMainTableViewCell.self
        )) { index, element, cell in
            cell.bindViewModel(element: (element, false))
            cell.selectionStyle = .none
        }.disposed(by: disposeBag)
    }
}
