//
//  CreateViewController.swift
//  90s
//
//  Created by 성다연 on 2021/04/10.
//

import UIKit
import SnapKit
import RxSwift

class FilmCreateViewController: BaseViewController {
    private var tableView : UITableView = {
        let tv = UITableView(frame: .zero)
        tv.showsHorizontalScrollIndicator = false
        return tv
    }()
    
    private let filmCreateInfoLabel : UILabel = {
        let label = UILabel(frame: .zero)
        let style = NSMutableParagraphStyle()
        style.lineSpacing = 5
        let attributes : [NSAttributedString.Key : Any] = [.paragraphStyle : style ]
        let attrString = NSAttributedString(string: "필름을\n선택해주세요", attributes: attributes)
        label.font = label.font.withSize(17)
        label.attributedText = attrString
        label.numberOfLines = 2
        return label
    }()
    
    private let viewModel = FilmsViewModel()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        navigationController?.navigationBar.isHidden = false
        setBarButtonItem(type: .imgClose, position: .left, action: #selector(handleNavLeftButton))
        setUpSubViews()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        setUpTableView()
    }
    
    private func setUpSubViews() {
        view.addSubview(tableView)
        view.addSubview(filmCreateInfoLabel)
        view.backgroundColor = .black
        
        filmCreateInfoLabel.snp.makeConstraints {
            $0.height.equalTo(105)
            $0.left.equalTo(view.safeAreaLayoutGuide).offset(18)
            $0.top.right.equalTo(view.safeAreaLayoutGuide)
        }
        
        tableView.snp.makeConstraints {
            $0.top.equalTo(filmCreateInfoLabel.snp.bottom)
            $0.left.right.bottom.equalTo(view.safeAreaLayoutGuide)
        }
        
        tableView.register(FilmListTableViewCell.self, forCellReuseIdentifier: FilmListTableViewCell.cellId)
    }
    
    private func setUpTableView(){
        tableView.delegate = self
        
        viewModel.FilmObservable.bind(to: tableView.rx.items(cellIdentifier: FilmListTableViewCell.cellId, cellType: FilmListTableViewCell.self)) { index, element, cell in
            cell.selectionStyle = .none
            cell.bindViewModel(film: element, isCreate: true)
        }.disposed(by: disposeBag)
    }
    
    @objc private func handleNavLeftButton(){
        navigationController?.popViewController(animated: true)
    }
}


extension FilmCreateViewController : UITableViewDelegate {
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 250
    }
}
