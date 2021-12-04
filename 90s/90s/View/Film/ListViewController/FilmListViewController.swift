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
    private let tableView : UITableView = {
        let tv = UITableView(frame: .zero, style: .grouped)
        tv.showsVerticalScrollIndicator = false
        tv.separatorStyle = .none
        
        // 필름 리스트를 보여주는 테이블 셀
        tv.register(FilmInfoTableViewCell.self, forCellReuseIdentifier: FilmInfoTableViewCell.cellId)
        // 필름 "인화할 시간!" 테이블 셀
        tv.register(FilmListPrintTableViewCell.self, forCellReuseIdentifier: FilmListPrintTableViewCell.cellID)
        // 필름 섹션 안내 문구 테이블 셀
        tv.register(FilmListSectionHeaderCell.self, forHeaderFooterViewReuseIdentifier: FilmListSectionHeaderCell.cellID)
        
        return tv
    }()
    
    private let popUpView : FilmPopupView = {
        let view = FilmPopupView()
        view.isHidden = true
        
        view.leftBtn.addTarget(self, action: #selector(popUpAnimation), for: .touchUpInside)
        view.rightBtn.addTarget(self, action: #selector(popUpDeleteButton), for: .touchUpInside)
        return view
    }()
    
    private let selectedFilmDeleteButton : UIButton = {
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
    
    private var viewModel = FilmListViewModel(dependency: .init())
    private var isEditingMode = false
    private var isTimeToPrintExist = false
    private var deleteFilmIndexPath : Set<IndexPath> = []

    private var FilmSection : [FilmListSectionModel] = []
    
    // MARK: - LifeCycle
    
    init(viewModel: FilmListViewModel) {
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setUpNavigationBar()
        setUpSubViews()
        setUpTableViewData()
        setUpTableViewSection()
    }
    
    // MARK: - Methods
    
    private func setUpNavigationBar() {
        setBarButtonItem(type: .textEdit, position: .right, action: #selector(handleNavigationRightButton))
        tabBarController?.tabBar.isHidden = true
        navigationController?.navigationBar.isHidden = false
        navigationItem.title = "내 필름"
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
//        viewModel.output.filmSectionViewModel.bind(to: { data in
//            data.value.forEach { item in
//                switch item.key {
//                case .adding:
//                    let array = item.value
//                    FilmSection.append(.sectionAdding(items: <#T##[Film]#>))
//                case .printing:
//                case .complete:
//                case default:
//                    break
//                }
//            }
//        })
        viewModel.output.film_timeToPrint.subscribe(onNext: { data in
            self.FilmSection.append(.sectionTimeToPrint(item: data.first!))
            self.isTimeToPrintExist = true
        }).disposed(by: disposeBag)

        viewModel.output.film_adding.subscribe(onNext: { data in
            self.FilmSection.append(.sectionAdding(items: data))
        }).disposed(by: disposeBag)

        viewModel.output.film_printing.subscribe(onNext: { data in
            self.FilmSection.append(.sectionPrinting(items: data))
        }).disposed(by: disposeBag)

        viewModel.output.film_complete.subscribe(onNext: { data in
            self.FilmSection.append(.sectionCompleted(items: data))
        }).disposed(by: disposeBag)
    }

    private func setUpTableViewSection(){
        tableView.rx.setDelegate(self).disposed(by: disposeBag)
        
        let dataSource = RxTableViewSectionedReloadDataSource<FilmListSectionModel> (configureCell: { dataSource, tableView, indexPath, item in
            if indexPath.section == 0 && self.isTimeToPrintExist {
                let cell = tableView.dequeueReusableCell(withIdentifier: FilmListPrintTableViewCell.cellID) as! FilmListPrintTableViewCell
                cell.bindViewModel(film: item)
                cell.selectionStyle = .none
                return cell
            }
            
            let cell = tableView.dequeueReusableCell(withIdentifier: FilmInfoTableViewCell.cellId) as! FilmInfoTableViewCell
            let value = self.deleteFilmIndexPath.contains(indexPath) ? true : false
            cell.bindViewModel(film: item, type: .adding)
            cell.isEditStarted(value: self.isEditingMode)
            cell.isEditCellSelected(value: value)
            cell.selectionStyle = .none
            return cell
        })
        
        Observable.just(FilmSection)
            .bind(to: tableView.rx.items(dataSource: dataSource))
            .disposed(by: disposeBag)
        
        tableView.rx.modelSelected(Film.self)
            .subscribe(onNext: { [weak self] item in
                if let bool = self?.isEditingMode {
                    if !bool {
                        let nextVC = FilmListDetailViewController(film: item)
                        self?.navigationController?.pushViewController(nextVC, animated: true)
                    }
                }
            }).disposed(by: disposeBag)
        
        
        tableView.rx.itemSelected
            .subscribe(onNext: { [weak self] indexPath in
                if let bool = self?.isEditingMode {
                    if bool {
                        if let array = self?.deleteFilmIndexPath,
                           let cell = self?.tableView.cellForRow(at: indexPath) as? FilmInfoTableViewCell {
                            if array.contains(indexPath) {
                                cell.isEditCellSelected(value: !bool)
                                self?.deleteFilmIndexPath.remove(indexPath)
                            } else {
                                cell.isEditCellSelected(value: bool)
                                self?.deleteFilmIndexPath.update(with: indexPath)
                            }
                            
                            let text = array.count > 0 ? "\(array.count)개 필름 삭제" : "필름을 선택해주세요"
                            self?.selectedFilmDeleteButton.setTitle(text, for: .normal)
                        }
                    } else {
//                        let nextVC = FilmListDetailViewController(film: item)
//                        self?.navigationController?.pushViewController(nextVC, animated: true)
                    }
                }
            }).disposed(by: disposeBag)
    }

    @objc private func handleNavigationRightButton() {
        if let rightBarItem = navigationItem.rightBarButtonItem {
            rightBarItem.title = rightBarItem.title == "편집" ? "취소" : "편집"
        }
        
        isEditingMode = !isEditingMode
        selectedFilmDeleteButton.setTitle("필름을 선택해주세요", for: .normal)
        selectedFilmDeleteButton.isHidden = !isEditingMode
        deleteFilmIndexPath.removeAll()
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
    
    @objc private func popUpAnimation(){
        UIView.animate(withDuration: 0.3, animations: { [weak self] in
            self?.popUpView.popupView.transform = CGAffineTransform(scaleX: 0.2, y: 0.2)
        }, completion: { _ in
            self.popUpView.isHidden = true
            self.popUpView.popupView.transform = CGAffineTransform(scaleX: 1.0, y: 1.0)
        })
        handleNavigationRightButton()
    }
    
    @objc private func popUpDeleteButton(){
        popUpAnimation()
    }
}


extension FilmListViewController : UITableViewDelegate {
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let header = tableView.dequeueReusableHeaderFooterView(withIdentifier: FilmListSectionHeaderCell.cellID) as! FilmListSectionHeaderCell
        let name = FilmSection[section].name
        
        header.backgroundView = UIView(frame: header.bounds)
        header.bindViewModel(text: name)
        header.bindBlackView(hidden: name == "인화를 완료했어요" ? false : true)
        
        return header
    }
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return FilmSection[section].heightForSection
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return FilmSection[indexPath.section].heightForRow
    }
}

