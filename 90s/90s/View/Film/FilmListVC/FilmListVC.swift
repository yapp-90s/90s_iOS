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
    private var tableView = UITableView(frame: .zero, style: .plain)
    
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
        view.addSubview(tableView)
        tableView.delegate = self
        tableView.showsVerticalScrollIndicator = false
        tableView.register(FilmListTableViewCell.self, forCellReuseIdentifier: FilmListTableViewCell.FilmListCellId)
        
        tableView.snp.makeConstraints {
            $0.edges.equalTo(view)
        }
    }
    
    private func bindViewModel(){
        viewModel.FilmObservable
            .map { $0.filter { $0.id != "0" }} // 필름 만들기 제외
            .bind(to: tableView.rx.items) { tableView, index, element in
                let cell = tableView.dequeueReusableCell(withIdentifier: "filmListCell") as! FilmListTableViewCell
                cell.bindViewModel(film: element)
                return cell
            }
            .disposed(by: disposeBag)
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 215
    }
}

