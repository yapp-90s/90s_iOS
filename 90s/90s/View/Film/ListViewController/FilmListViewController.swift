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
final class FilmListViewController: BaseViewController {
    private var tableView : UITableView = {
        let tv = UITableView(frame: .zero, style: .grouped)
        tv.showsVerticalScrollIndicator = false
        tv.separatorStyle = .none
        
        tv.register(FilmListTableViewCell.self, forCellReuseIdentifier: FilmListTableViewCell.cellId)
        tv.register(FilmListPrintTableViewCell.self, forCellReuseIdentifier: FilmListPrintTableViewCell.cellID)
        tv.register(FilmListSectionHeaderCell.self, forHeaderFooterViewReuseIdentifier: FilmListSectionHeaderCell.cellID)
        
        return tv
    }()
    
    private var popUpView : FilmPopupView = {
        let view = FilmPopupView()
        view.isHidden = true
        
        view.leftBtn.addTarget(self, action: #selector(popUpLeftBtn), for: .touchUpInside)
        view.rightBtn.addTarget(self, action: #selector(popUpRightBtn), for: .touchUpInside)
        return view
    }()
    
    private var selectedFilmDeleteButton : UIButton = {
        let btn = UIButton(frame: .zero)
        btn.isHidden = true
        btn.backgroundColor = .retroOrange
        btn.titleLabel?.font = .boldSystemFont(ofSize: 15)
        btn.setTitle("필름을 선택해주세요", for: .normal)
        btn.titleEdgeInsets = UIEdgeInsets(top: 0, left: 0, bottom: 30, right: 0)
        btn.addTarget(self, action: #selector(selectDeleteBtn), for: .touchUpInside)
        return btn
    }()
    
    // MARK: - Property
    
    private let viewModel = FilmsViewModel(dependency: .init())
    private var isEditingMode = false
    private var deleteFilmIndexPath : Set<IndexPath> = []

    private var FilmSection : [FilmListSectionModel] = []
    private var dataSource : RxTableViewSectionedReloadDataSource<FilmListSectionModel>?
    
    // MARK: - LifeCycle

    override func viewDidLoad() {
        super.viewDidLoad()
        setUpNavigationBar()
        setUpSubViews()
        setUpTableViewData()
        setUpTableViewSection()
    }
    
    // MARK: - Methods
    
    private func setUpNavigationBar() {
        setBarButtonItem(type: .textEdit, position: .right, action: #selector(handleNavigationRightButtonEdit))
        tabBarController?.tabBar.isHidden = true
        navigationController?.navigationBar.isHidden = false
        navigationItem.title = "내 필름"
        view.backgroundColor = .black
    }

    private func setUpSubViews(){
        view.addSubview(tableView)
        view.addSubview(selectedFilmDeleteButton)
        view.addSubview(popUpView)
        
        tableView.snp.makeConstraints {
            $0.top.left.right.bottom.equalTo(view.safeAreaLayoutGuide)
        }
        
        selectedFilmDeleteButton.snp.makeConstraints {
            $0.height.equalTo(94)
            $0.left.right.bottom.equalToSuperview()
        }
        
        popUpView.snp.makeConstraints {
            $0.edges.equalToSuperview()
        }
    }
    
    private func setUpTableViewData() {
        let filmArray = viewModel.getStateData(state: .adding).filter { $0.count == $0.maxCount }
        if !filmArray.isEmpty {
            FilmSection.append(.sectionTimeToPrint(item: filmArray.first!))
        }
        
        FilmSection.append(contentsOf: [
            .sectionAdding(items: viewModel.getStateData(state: .adding)),
            .sectionPrinting(items: viewModel.getStateData(state: .printing)),
            .sectionCompleted(items: viewModel.getStateData(state: .complete))
        ])
    }

    private func setUpTableViewSection(){
        tableView.rx.setDelegate(self).disposed(by: disposeBag)
        
        dataSource = RxTableViewSectionedReloadDataSource<FilmListSectionModel> (configureCell: { dataSource, tableView, indexPath, item in
            if indexPath.section == 0 && self.FilmSection.count == 4 {
                let cell = tableView.dequeueReusableCell(withIdentifier: FilmListPrintTableViewCell.cellID) as! FilmListPrintTableViewCell
                cell.bindViewModel(film: item)
                cell.selectionStyle = .none
                return cell
            }
            
            let cell = tableView.dequeueReusableCell(withIdentifier: FilmListTableViewCell.cellId) as! FilmListTableViewCell
            let value = self.deleteFilmIndexPath.contains(indexPath) ? true : false
            cell.bindViewModel(film: item, isCreate: false)
            cell.isEditStarted(value: self.isEditingMode)
            cell.isEditCellSelected(value: value)
            cell.selectionStyle = .none
            return cell
        })
        
        Observable.just(FilmSection)
            .bind(to: tableView.rx.items(dataSource: dataSource!))
            .disposed(by: disposeBag)
        
        
        tableView.rx.modelSelected(Film.self)
            .subscribe(onNext: { [weak self] item in
                if let bool = self?.isEditingMode {
                    if !bool, item.count != item.maxCount {
                        let nextVC = FilmListDetailViewController()
                        nextVC.bindViewModel(film: item)
                        self?.navigationController?.pushViewController(nextVC, animated: true)
                    }
                }
            }).disposed(by: disposeBag)
        
        
        tableView.rx.itemSelected
            .subscribe(onNext: { [weak self] indexPath in
                if let bool = self?.isEditingMode,
                   let array = self?.deleteFilmIndexPath {
                   
                    if let cell = self?.tableView.cellForRow(at: indexPath) as? FilmListTableViewCell {
                        if bool {
                            if array.contains(indexPath) {
                                cell.isEditCellSelected(value: !bool)
                                self?.deleteFilmIndexPath.remove(indexPath)
                            } else {
                                cell.isEditCellSelected(value: bool)
                                self?.deleteFilmIndexPath.update(with: indexPath)
                            }
                            
                            if let count = self?.deleteFilmIndexPath.count {
                                let text = count > 0 ? "\(count)개 필름 삭제" : "필름을 선택해주세요"
                                self?.selectedFilmDeleteButton.setTitle(text, for: .normal)
                            }
                        }
                    }
                }
            }).disposed(by: disposeBag)
    }
    
    // 개선할 곳 start ~
    @objc private func handleNavigationRightButtonEdit(){
        handleNavigationRightButton()
        setBarButtonItem(type: .textCancle, position: .right, action: #selector(handleNavigationRightButtonCancle))
    }
    
    @objc private func handleNavigationRightButtonCancle(){
        handleNavigationRightButton()
        setBarButtonItem(type: .textEdit, position: .right, action: #selector(handleNavigationRightButtonEdit))
    }
   
    @objc private func handleNavigationRightButton() {
        isEditingMode = !isEditingMode
        selectedFilmDeleteButton.setTitle("필름을 선택해주세요", for: .normal)
        selectedFilmDeleteButton.isHidden = !isEditingMode
        deleteFilmIndexPath.removeAll()
        tableView.reloadData()
    }
    // ~ end
    
    @objc private func selectDeleteBtn(){
        popUpView.isHidden = false
        popUpView.alpha = 1
        popUpView.transform = CGAffineTransform(scaleX: 1.2, y: 1.2)
        
        UIView.animate(withDuration: 0.5) { [weak self] in
            self?.popUpView.transform = .identity
        }
    }
    
    @objc private func popUpLeftBtn(){
        UIView.animate(withDuration: 0.3, animations: { [weak self] in
            self?.popUpView.popupView.transform = CGAffineTransform(scaleX: 0.2, y: 0.2)
        }, completion: { _ in
            self.popUpView.isHidden = true
            self.popUpView.popupView.transform = CGAffineTransform(scaleX: 1.0, y: 1.0)
        })
        handleNavigationRightButton()
    }
    @objc private func popUpRightBtn(){
        UIView.animate(withDuration: 0.3, animations: { [weak self] in
            self?.popUpView.popupView.transform = CGAffineTransform(scaleX: 0.2, y: 0.2)
        }, completion: { _ in
            self.popUpView.isHidden = true
            self.popUpView.popupView.transform = CGAffineTransform(scaleX: 1.0, y: 1.0)
        })
        handleNavigationRightButton()
        print("need delete code")
    }
}


extension FilmListViewController : UITableViewDelegate {
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let header = tableView.dequeueReusableHeaderFooterView(withIdentifier: FilmListSectionHeaderCell.cellID) as! FilmListSectionHeaderCell
        var value : (String, Bool) = ("", false)
        
        switch FilmSection.count < 4 ? section + 1 : section {
        case 0:
            value = ("인화할 시간!", true)
        case 1:
            value = ("사진을 추가하고 있어요", true)
        case 2:
            value = ("지금 인화하고 있어요", true)
        default:
            value = ("인화를 완료했어요", false)
        }
        
        header.backgroundView = UIView(frame: header.bounds)
        header.bindViewModel(text: value.0)
        header.bindBlackView(hidden: value.1)
        
        return header
    }
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        if FilmSection.count == 4 {
            return section == 1 ? 50 : 70
        }
        return section == 0 ? 50 : 70
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return indexPath.section == 0 && FilmSection.count == 4 ? 360 : 215
    }
}

