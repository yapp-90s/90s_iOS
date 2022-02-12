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
final class FilmListViewController: BaseViewController, UIScrollViewDelegate {
    private let tableView : UITableView = {
        let tv = UITableView(frame: .zero, style: .grouped)
        tv.showsVerticalScrollIndicator = false
        tv.separatorStyle = .none
        
        // 필름 리스트를 보여주는 테이블 셀
        tv.register(reusable: FilmInfoTableViewCell.self)
        // 필름 "인화할 시간!" 테이블 셀
        tv.register(reusable: FilmListPrintTableViewCell.self)
        // 필름 섹션 안내 문구 테이블 셀
        tv.registerHeader(reusable: FilmListSectionHeaderCell.self)
        
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
//        btn.titleEdgeInsets = UIEdgeInsets(top: 0, left: 0, bottom: 30, right: 0)
        btn.addTarget(self, action: #selector(selectDeleteBtn), for: .touchUpInside)
        return btn
    }()
    
    // MARK: - Property
    
    private var viewModel : FilmsViewModel
    private var isEditingMode = false                       // 편집 모드
    private var isTimeToPrintExist = false
    private var deleteFilmIndexPath : Set<IndexPath> = []   // 삭제할 필름 IndexPath 배열

    // MARK: - LifeCycle
    
    init(viewModel: FilmsViewModel) {
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
        setUpTableViewDataSource()
    }
    
    // MARK: - Methods
    
    private func setUpNavigationBar() {
        viewModel.output.sectionArray.subscribe(onNext: { filmList in
            if filmList.count > 0 {
                self.setBarButtonItem(type: .textEdit, position: .right, action: #selector(self.handleNavigationRightButton))
            }
        }).disposed(by: disposeBag)
        
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
            $0.top.equalTo(view.safeAreaLayoutGuide.snp.bottom).offset(-60)
            $0.left.right.bottom.equalToSuperview()
        }
        
        popUpView.snp.makeConstraints {
            $0.edges.equalToSuperview()
        }
        
    }

    private func setUpTableViewDataSource(){
        tableView.rx.setDelegate(self).disposed(by: disposeBag)
        
        let dataSource = RxTableViewSectionedReloadDataSource<FilmSectionModel> (configureCell: { dataSource, tableView, indexPath, item in
            if indexPath.section == 0 && self.isTimeToPrintExist {
                let cell = tableView.dequeueReusableCell(withIdentifier: FilmListPrintTableViewCell.reuseIdentifier) as! FilmListPrintTableViewCell
                cell.bindViewModel(film: item.returnFilm())
                cell.selectionStyle = .none
                return cell
            }
            
            let cell = tableView.dequeueReusableCell(withIdentifier: FilmInfoTableViewCell.reuseIdentifier) as! FilmInfoTableViewCell
            let value = self.deleteFilmIndexPath.contains(indexPath) ? true : false
            cell.bindViewModel(film: item.returnFilm(), type: .adding)
            cell.isEditStarted(value: self.isEditingMode)
            cell.isEditCellSelected(value: value)
            cell.selectionStyle = .none
            return cell
        })
        
        viewModel.output.sectionArray
            .bind(to: tableView.rx.items(dataSource: dataSource))
            .disposed(by: disposeBag)
        
        tableView.rx.modelSelected(FilmSectionItem.self)
            .subscribe(onNext: { [weak self] film in
                guard let checkSelf = self else { return }
                
                if !checkSelf.isEditingMode {
                    let nextVC = FilmListDetailViewController(viewModel: film.returnFilm())
                    self?.navigationController?.pushViewController(nextVC, animated: true)
                }
            }).disposed(by: disposeBag)
        
        
        tableView.rx.itemSelected
            .subscribe(onNext: { [weak self] indexPath in
                guard let checkSelf = self else { return }
                
                if checkSelf.isEditingMode {
                    let cell = checkSelf.tableView.cellForRow(at: indexPath) as! FilmInfoTableViewCell

                    if checkSelf.deleteFilmIndexPath.contains(indexPath) {
                        cell.isEditCellSelected(value: !checkSelf.isEditingMode)
                        checkSelf.deleteFilmIndexPath.remove(indexPath)
                    } else {
                        cell.isEditCellSelected(value: checkSelf.isEditingMode)
                        checkSelf.deleteFilmIndexPath.update(with: indexPath)
                    }
                    
                    let text = checkSelf.deleteFilmIndexPath.count > 0 ? "\(checkSelf.deleteFilmIndexPath.count)개 필름 삭제" : "필름을 선택해주세요"
                    self?.selectedFilmDeleteButton.setTitle(text, for: .normal)
                } else {
                    // TODO: - 삭제할 필름 리스트 가져와 삭제하기
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
        guard let header = tableView.dequeueReusableHeaderFooterView(withIdentifier: FilmListSectionHeaderCell.reuseIdentifier) as? FilmListSectionHeaderCell else { return UIView() }
        
        viewModel.output.sectionArray
            .subscribe(onNext: { list in
            guard let firstItem = list[section].items.first else { return }
            header.bindViewModel(text: firstItem.sectionTitle())
            header.bindBlackView(hidden: firstItem.sectionTitle() == "인화를 완료했어요" ? false : true)
        }).disposed(by: disposeBag)
        
        header.backgroundView = UIView(frame: header.bounds)

        return header
    }
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        var height : CGFloat = 0.0
        
        viewModel.output.sectionArray.subscribe(onNext: { list in
            height = list[section].items[0].sectionHeight()
        }).disposed(by: disposeBag)
        
        return height
    }

    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        var height : CGFloat = 0.0
        
        viewModel.output.sectionArray.subscribe(onNext: {list in
            height = list[indexPath.section].items[indexPath.row].rowHeight()
        }).disposed(by: disposeBag)
        
        return height
        
    }
}

