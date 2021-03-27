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
class FilmListViewController: UIViewController {
    private var navigationBar: NavigationBar = {
        let navBar = NavigationBar(frame: .zero)
        navBar.titleLabel.text = "내 필름"
        navBar.rightButton.setUpNavBarRightBtn(type: .text_edit)
        return navBar
    }()
    
    private var tableView : UITableView = {
        let tv = UITableView(frame: .zero, style: .grouped)
        tv.showsVerticalScrollIndicator = false
        tv.separatorStyle = .none
        return tv
    }()
    
    private var popUpView : FilmPopupView = {
        let view = FilmPopupView()
        view.isHidden = true
        return view
    }()
    
    private var selectedFilmDeleteButton : UIButton = {
        let btn = UIButton(frame: .zero)
        btn.backgroundColor = ColorType.retro_Orange.create()
        btn.titleLabel?.font = .boldSystemFont(ofSize: 15)
        btn.setTitle("필름을 선택해주세요", for: .normal)
        btn.titleEdgeInsets = UIEdgeInsets(top: 0, left: 0, bottom: 30, right: 0)
        btn.isHidden = true
        btn.addTarget(self, action: #selector(selectDeleteBtn), for: .touchUpInside)
        return btn
    }()
    
    private let viewModel = FilmsViewModel()
    private var disposeBag = DisposeBag()
    private var isEditingMode = false
    private var deleteFilmIndexPath : Set<IndexPath> = []

    private var FilmSection : [FilmListSectionData] = []
    private var dataSource : RxTableViewSectionedReloadDataSource<FilmListSectionData>?

    override func viewDidLoad() {
        super.viewDidLoad()
        setUpSubViews()
        setUpTableViewSection()
    }

    private func setUpSubViews(){
        tabBarController?.tabBar.isHidden = true
        view.backgroundColor = .black
        
        view.addSubview(tableView)
        view.addSubview(navigationBar)
        view.addSubview(selectedFilmDeleteButton)
        view.addSubview(popUpView)
        
        tableView.delegate = self
        tableView.register(FilmListTableViewCell.self, forCellReuseIdentifier: FilmListTableViewCell.cellId)
        tableView.register(FilmListPrintTableViewCell.self, forCellReuseIdentifier: FilmListPrintTableViewCell.cellID)
        tableView.register(FilmListSectionHeaderCell.self, forHeaderFooterViewReuseIdentifier: FilmListSectionHeaderCell.cellID)
        
        navigationBar.snp.makeConstraints {
            $0.height.equalTo(52)
            $0.top.left.right.equalTo(view.safeAreaLayoutGuide)
        }
        
        tableView.snp.makeConstraints {
            $0.top.equalTo(navigationBar.snp.bottom)
            $0.left.right.bottom.equalTo(view.safeAreaLayoutGuide)
        }
        
        selectedFilmDeleteButton.snp.makeConstraints {
            $0.height.equalTo(94)
            $0.left.right.bottom.equalTo(view)
        }
        
        popUpView.snp.makeConstraints {
            $0.edges.equalTo(view)
        }
        
        navigationBar.leftButton.addTarget(self, action: #selector(popUp), for: .touchUpInside)
        navigationBar.rightButton.addTarget(self, action: #selector(editTableView), for: .touchUpInside)
        popUpView.leftBtn.addTarget(self, action: #selector(popUpLeftBtn), for: .touchUpInside)
        popUpView.rightBtn.addTarget(self, action: #selector(popUpRightBtn), for: .touchUpInside)
    }

    private func setUpTableViewSection(){
        let filmArray = viewModel.getStateData(state: .adding).filter { $0.count == $0.maxCount }
        if !filmArray.isEmpty {
            FilmSection.append(FilmListSectionData(header: "", items: filmArray))
        }
        
        FilmSection.append(contentsOf: [
            FilmListSectionData(header: "", items: viewModel.getStateData(state: .adding)),
            FilmListSectionData(header: "", items: viewModel.getStateData(state: .printing)),
            FilmListSectionData(header: "", items: viewModel.getStateData(state: .complete))
        ])
        
        dataSource = RxTableViewSectionedReloadDataSource<FilmListSectionData> (configureCell: { dataSource, tableView, indexPath, item in
            if indexPath.section == 0 && self.FilmSection.count == 4 {
                let cell = tableView.dequeueReusableCell(withIdentifier: FilmListPrintTableViewCell.cellID) as! FilmListPrintTableViewCell
                cell.bindViewModel(film: item)
                cell.selectionStyle = .none
                return cell
            }
            
            let cell = tableView.dequeueReusableCell(withIdentifier: FilmListTableViewCell.cellId) as! FilmListTableViewCell
            let value = self.deleteFilmIndexPath.contains(indexPath) ? true : false
            
            cell.bindViewModel(film: item)
            cell.isEditStarted(value: self.isEditingMode)
            cell.isEditCellSelected(value: value)
            cell.selectionStyle = .none
            return cell
        }, titleForHeaderInSection: { dataSource, sectionIndex in
            return dataSource[sectionIndex].header
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
    
    @objc private func popUp(){
        navigationController?.popViewController(animated: true)
    }
    
    @objc private func editTableView(){
        selectedFilmDeleteButton.setTitle("필름을 선택해주세요", for: .normal)
        selectedFilmDeleteButton.isHidden = isEditingMode
        navigationBar.rightButton.setTitle(isEditingMode ? "편집" : "취소", for: .normal)
        deleteFilmIndexPath.removeAll()
        isEditingMode = !isEditingMode
        tableView.reloadData()
    }
    
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
        editTableView()
    }
    @objc private func popUpRightBtn(){
        UIView.animate(withDuration: 0.3, animations: { [weak self] in
            self?.popUpView.popupView.transform = CGAffineTransform(scaleX: 0.2, y: 0.2)
        }, completion: { _ in
            self.popUpView.isHidden = true
            self.popUpView.popupView.transform = CGAffineTransform(scaleX: 1.0, y: 1.0)
        })
        editTableView()
        print("need delete code")
    }
}


extension FilmListViewController : UITableViewDelegate {
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let header = tableView.dequeueReusableHeaderFooterView(withIdentifier: FilmListSectionHeaderCell.cellID) as! FilmListSectionHeaderCell
        var value : (String, Bool) = ("", false)

        header.backgroundView = UIView(frame: header.bounds)
        
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

