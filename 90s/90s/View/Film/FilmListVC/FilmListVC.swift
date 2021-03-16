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
    private var navigationBar: NavigationBar = {
        let navBar = NavigationBar(frame: .zero)
        navBar.titleLabel.text = "내 필름"
        navBar.rightBtn.setUpNavBarRightBtn(type: .text_edit)
        return navBar
    }()
    
    private var tableView : UITableView = {
        let tv = UITableView(frame: .zero, style: .grouped)
        tv.showsVerticalScrollIndicator = false
        tv.separatorStyle = .none
        tv.backgroundColor = .white
        return tv
    }()
    
    private let viewModel = FilmsViewModel()
    private var disposeBag = DisposeBag()
    private var isEditingMode = false
    
    var section : [FilmListSectionData] = []
    var dataSource : RxTableViewSectionedReloadDataSource<FilmListSectionData>?

    override func viewDidLoad() {
        super.viewDidLoad()
        setUpSubViews()
        setUpTableViewSection()
    }
}


extension FilmListVC {
    private func setUpSubViews(){
        view.addSubview(tableView)
        view.addSubview(navigationBar)
        
        tableView.delegate = self
        tableView.register(FilmListTableViewCell.self, forCellReuseIdentifier: FilmListTableViewCell.FilmListCellId)
        tableView.register(FilmListSectionHeaderCell.self, forHeaderFooterViewReuseIdentifier: FilmListSectionHeaderCell.FilmListSectionHeaderCellID)
        
        navigationBar.snp.makeConstraints {
            $0.height.equalTo(52)
            $0.top.left.right.equalTo(view.safeAreaLayoutGuide)
        }
        
        tableView.snp.makeConstraints {
            $0.top.equalTo(navigationBar.snp.bottom)
            $0.left.right.bottom.equalTo(view)
        }
        
        navigationBar.leftBtn.addTarget(self, action: #selector(popUp), for: .touchUpInside)
        navigationBar.rightBtn.addTarget(self, action: #selector(editTableView), for: .touchUpInside)
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
            cell.isEditStarted(value: self.isEditingMode)
            cell.selectionStyle = .none
            return cell
        }, titleForHeaderInSection: { dataSource, sectionIndex in
            return dataSource[sectionIndex].header
        })
        
        Observable.just(section)
            .bind(to: tableView.rx.items(dataSource: dataSource!))
            .disposed(by: disposeBag)
        
        
        tableView.rx.modelSelected(Film.self)
            .subscribe(onNext: { [weak self] item in
                if let bool = self?.isEditingMode {
                    if !bool {
                        let nextVC = FilmListDetailViewController()
                        nextVC.bindViewModel(film: item)
                        self?.navigationController?.pushViewController(nextVC, animated: true)
                    }
                }
            }).disposed(by: disposeBag)
        
        tableView.rx.itemSelected
            .subscribe(onNext: { [weak self] indexPath in
                if let bool = self?.isEditingMode {
                    if bool {
                        let cell = self?.tableView.cellForRow(at: indexPath) as? FilmListTableViewCell
                        cell?.isEditCellSelected(value: bool)
                    }
                }
            }).disposed(by: disposeBag)
    }
    
    @objc private func popUp(){
        navigationController?.popViewController(animated: true)
    }
    @objc private func editTableView(){
        isEditingMode = true
        navigationBar.rightBtn.isHidden = true
        tableView.reloadData()
    }
}


extension FilmListVC : UITableViewDelegate {
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let header = tableView.dequeueReusableHeaderFooterView(withIdentifier: FilmListSectionHeaderCell.FilmListSectionHeaderCellID) as! FilmListSectionHeaderCell
        var value : (String, Bool) = ("", false)

        header.backgroundView = UIView(frame: header.bounds)
        header.backgroundView?.backgroundColor = .white
            
        switch section {
        case 0:
            value = ("사진을 추가하고 있어요", true)
        case 1:
            value = ("지금 인화하고 있어요", true)
        default:
            value = ("", false)
        }
        
        header.bindViewModel(text: value.0)
        header.bindBlackView(hidden: value.1)
        
        return header
    }
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        switch section {
        case 0:
            return 50.0
        case 1:
            return 70.0
        default :
            return 40.0
        }
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 215
    }
}

