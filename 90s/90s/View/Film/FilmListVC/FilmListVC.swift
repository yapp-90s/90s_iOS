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
    private var tableView = UITableView(frame: .zero, style: .grouped)
    
    private let viewModel = FilmsViewModel()
    private var disposeBag = DisposeBag()
    
    var section : [FilmListSectionData] = []
    var dataSource : RxTableViewSectionedReloadDataSource<FilmListSectionData>?

    override func viewDidLoad() {
        super.viewDidLoad()
        setUpTableView()
        setUpTableViewSection()
    }
}


extension FilmListVC : UITableViewDelegate {
    private func setUpTableView(){
        view.addSubview(tableView)
        tableView.delegate = self
        tableView.showsVerticalScrollIndicator = false
        tableView.separatorStyle = .none
        tableView.backgroundColor = .white
        
        tableView.register(FilmListTableViewCell.self, forCellReuseIdentifier: FilmListTableViewCell.FilmListCellId)
        tableView.register(FilmListSectionHeaderCell.self, forHeaderFooterViewReuseIdentifier: FilmListSectionHeaderCell.FilmListSectionHeaderCellID)
        
        tableView.snp.makeConstraints {
            $0.edges.equalTo(view)
        }
    }
    
    private func setUpTableViewSection(){
        section = [
            FilmListSectionData(header: "", items: viewModel.getStateData(state: .adding)),
            FilmListSectionData(header: "", items: viewModel.getStateData(state: .printing)),
            FilmListSectionData(header: "", items: viewModel.getStateData(state: .complete))
        ]
        
        dataSource = RxTableViewSectionedReloadDataSource<FilmListSectionData> (configureCell: { dataSource, tableView, indexPath, item in
            let cell = tableView.dequeueReusableCell(withIdentifier: FilmListTableViewCell.FilmListCellId) as! FilmListTableViewCell
            cell.bindViewModel(film: item)
            return cell
        }, titleForHeaderInSection: { dataSource, sectionIndex in
            return dataSource[sectionIndex].header
        })
        
        
        Observable.just(section)
            .bind(to: tableView.rx.items(dataSource: dataSource!))
            .disposed(by: disposeBag)
    }
}

extension FilmListVC {
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let header = tableView.dequeueReusableHeaderFooterView(withIdentifier: FilmListSectionHeaderCell.FilmListSectionHeaderCellID) as! FilmListSectionHeaderCell
        
        header.backgroundView = UIView(frame: header.bounds)
        header.backgroundView?.backgroundColor = .white
        
        switch section {
        case 0:
            header.bindViewModel(text: "사진을 추가해보세요!")
            header.bindBlackView(hidden: true)
        case 1:
            header.bindViewModel(text: "지금 인화하고 있어요")
            header.bindBlackView(hidden: true)
        case 2:
            header.bindViewModel(text: "")
            header.bindBlackView(hidden: false)
        default:
            header.bindViewModel(text: "")
        }
        
        return header
    }
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        switch section {
        case 0:
            return 50.0
        case 1:
            return 70.0
        case 2:
            return 40.0
        default :
            return 40.0
        }
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 215
    }
}

