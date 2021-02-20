//
//  FilmListVC.swift
//  90s
//
//  Created by 성다연 on 2021/02/20.
//

import UIKit
import SnapKit
import RxSwift
import RxCocoa
import RxDataSources

/// 필름 리스트
class FilmListVC: UIViewController {
    private var tableView = UITableView(frame: .zero)
    
    private let viewModel = FilmsViewModel()
    private var disposeBag = DisposeBag()
    
//    let dataSource = RxTableViewSectionedReloadDataSource
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setUpTableView()
        bindViewModel()
    }
}


extension FilmListVC : UITableViewDelegate {
    private func setUpTableView(){
        tableView.delegate = self
        
        tableView.snp.makeConstraints {
            $0.edges.equalTo(view.safeAreaLayoutGuide)
        }
    }
    
    private func bindViewModel(){
        viewModel.FilmObservable
            .bind(to: tableView.rx.items) { tableView, index, element in
                let cell = tableView.dequeueReusableCell(withIdentifier: "filmListCell") as! FilmListTableViewCell
                cell.bindViewModel(film: element)
                return cell
            }
            .disposed(by: disposeBag)
    }
}

