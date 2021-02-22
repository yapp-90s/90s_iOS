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


struct FilmListSectionData {
    var header : String
    var items: [Item]
}

extension FilmListSectionData : SectionModelType {
    typealias Item = Film
    
    init(original: FilmListSectionData, items: [Film]) {
        self = original
        self.items = items
    }
}

/// 필름 리스트
class FilmListVC: UIViewController {
    private var tableView = UITableView(frame: .zero, style: .plain)
    
    private let viewModel = FilmsViewModel()
    private var disposeBag = DisposeBag()
    
    var section : [FilmListSectionData] = []
    var dataSource : RxTableViewSectionedReloadDataSource<FilmListSectionData>?

    override func viewDidLoad() {
        super.viewDidLoad()
        setUpTableView()
        setSection()
        bindViewModel()
    }
}


extension FilmListVC : UITableViewDelegate {
    private func setUpTableView(){
        view.addSubview(tableView)
        tableView.delegate = self
        tableView.showsVerticalScrollIndicator = false
        tableView.separatorStyle = .none
        tableView.register(FilmListTableViewCell.self, forCellReuseIdentifier: FilmListTableViewCell.FilmListCellId)
        
        tableView.snp.makeConstraints {
            $0.edges.equalTo(view)
        }
    }
    
    private func setSection(){
        section = [
            FilmListSectionData(header: "사진을 추가해주세요!", items: viewModel.getStateData(state: .adding)),
            FilmListSectionData(header: "지금 인화하고 있어요", items: viewModel.getStateData(state: .adding)),
            FilmListSectionData(header: "", items: viewModel.getStateData(state: .adding))
        ]
        
        dataSource = RxTableViewSectionedReloadDataSource<FilmListSectionData> (configureCell: { dataSource, tableView, indexPath, item in
            let cell = tableView.dequeueReusableCell(withIdentifier: FilmListTableViewCell.FilmListCellId) as! FilmListTableViewCell
            cell.bindViewModel(film: item)
            
            return cell
        }, titleForHeaderInSection: { dataSource, sectionIndex in
            return dataSource[sectionIndex].header
        })
    }
    
    private func bindViewModel(){
        viewModel.FilmObservable
            .map { $0.filter { $0.id != "0" }} // 필름 만들기 제외
            .bind(to: tableView.rx.items) { tableView, index, element in
                let cell = tableView.dequeueReusableCell(withIdentifier: FilmListTableViewCell.FilmListCellId) as! FilmListTableViewCell
                cell.bindViewModel(film: element)
                
                return cell
            }
            .disposed(by: disposeBag)
        
        Observable.just(section)
            .bind(to: tableView.rx.items(dataSource: dataSource!))
            .disposed(by: disposeBag)
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 215
    }
}

