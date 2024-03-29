//
//  CreateViewController.swift
//  90s
//
//  Created by 성다연 on 2021/04/10.
//

import UIKit
import SnapKit
import RxSwift

protocol FilmCreateViewControllerDelegate {
    func presentFilmCreateVC(film: Film)
    func popupToFilmCreateVC()
}

final class FilmCreateViewController: BaseViewController {
    private var tableView : UITableView = {
        let tv = UITableView(frame: .zero)
        tv.showsHorizontalScrollIndicator = false
        tv.separatorStyle = .none
        tv.rowHeight = 250
        tv.register(reusable: FilmInfoTableViewCell.self)
        
        return tv
    }()
    
    private let filmCreateInfoLabel : UILabel = {
        let label = UILabel.createSpacingLabel(text: "필름을\n선택해주세요")
        label.font = .Sub_Head
        return label
    }()
    
    
    private let viewModel : Observable<[Film]> = Observable.from(optional: FilmFactory().createFilmCategoryList())
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setUpSubViews()
        setUpTableView()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        tabBarController?.tabBar.isHidden = true
    }
    
    private func setUpSubViews() {
        navigationController?.navigationBar.isHidden = false
        view.backgroundColor = .black
        view.addSubview(tableView)
        view.addSubview(filmCreateInfoLabel)
        
        filmCreateInfoLabel.snp.makeConstraints {
            $0.height.equalTo(105)
            $0.left.equalTo(view.safeAreaLayoutGuide).offset(18)
            $0.top.right.equalTo(view.safeAreaLayoutGuide)
        }
        
        tableView.snp.makeConstraints {
            $0.top.equalTo(filmCreateInfoLabel.snp.bottom)
            $0.left.right.bottom.equalTo(view.safeAreaLayoutGuide)
        }
    }
    
    private func setUpTableView(){
        viewModel.bind(to: tableView.rx.items(cellIdentifier: FilmInfoTableViewCell.reuseIdentifier, cellType: FilmInfoTableViewCell.self)) { index, element, cell in
            cell.selectionStyle = .none
            cell.bindViewModel(film: element, type: .create)
        }.disposed(by: disposeBag)
        
        tableView.rx.modelSelected(Film.self).subscribe(onNext: { film in
            let nextVC = FilmCreateDetailViewController(viewModel: film)
            nextVC.delegate = self
            self.navigationController?.pushViewController(nextVC, animated: true)
        }).disposed(by: disposeBag)
    }
}


extension FilmCreateViewController : FilmCreateViewControllerDelegate {
    func presentFilmCreateVC(film: Film) {
        let nextVC = FilmCreateNameViewController(viewModel: film)
        nextVC.delegate = self
        navigationController?.pushViewController(nextVC, animated: true)
    }
    
    func popupToFilmCreateVC(){
        navigationController?.popToViewController(self, animated: true)
    }
}
