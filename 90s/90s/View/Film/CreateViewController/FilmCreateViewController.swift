//
//  CreateViewController.swift
//  90s
//
//  Created by 성다연 on 2021/04/10.
//

import UIKit
import SnapKit
import RxSwift

class FilmCreateViewController: UIViewController {
    private var tableView : UITableView = {
        let tv = UITableView(frame: .zero)
        tv.showsHorizontalScrollIndicator = false
        return tv
    }()
    
    private let filmCreateInfoLabel : UILabel = {
        let label = UILabel(frame: .zero)
        label.text = "필름을 선택해주세요"
//        let style = NSMutableParagraphStyle()
//        style.lineSpacing = 5
//        let string = NSMutableAttributedString(string:  "필름을 선택해주세요")
//        string.addAttributes(style, range: NSMakeRange(0, string.length))
//        label.attributedText = string
        label.numberOfLines = 2
        return label
    }()
    
    private let viewModel = FilmsViewModel()
    private var disposeBag = DisposeBag()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setUpSubViews()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        setUpTableView()
    }
    
    private func setUpSubViews() {
        view.addSubview(tableView)
        view.addSubview(filmCreateInfoLabel)
        
        filmCreateInfoLabel.snp.makeConstraints {
            $0.height.equalTo(105)
            $0.top.left.right.equalTo(view.safeAreaLayoutGuide)
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
            cell.bindViewModel(film: element, isCreate: false)
        }.disposed(by: disposeBag)
    }
}


extension FilmCreateViewController : UITableViewDelegate {
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 250
    }
}
