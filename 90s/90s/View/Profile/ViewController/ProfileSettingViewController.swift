//
//  ProfileSettingViewController.swift
//  90s
//
//  Created by 성다연 on 2021/07/02.
//

import UIKit
import SnapKit
import RxSwift

final class ProfileSettingViewController: BaseViewController, UIScrollViewDelegate {
    
    private var tableView : UITableView = {
        let tv = UITableView(frame: .zero)
        tv.isScrollEnabled = false
        tv.showsVerticalScrollIndicator = false
        tv.separatorStyle = .none
        tv.rowHeight = 70
        
        tv.register(reusable: ProfileSettingTableViewCell.self)
        return tv
    }()
    
    private let leaveView : UIView = {
        let view = UIView(frame: .zero)
        view.clipsToBounds = true
        view.layer.cornerRadius = 8
        view.backgroundColor = .Cool_Gray
        view.isHidden = true
        return view
    }()
    
    private let leaveTitleLabel : UILabel = {
        let label = UILabel(frame: .zero)
        label.font = .Popup_Title
        label.text = "정말 떠나실 건가요?"
        label.textAlignment = .center
        return label
    }()
    
    private let leaveSubTitleLabel : UILabel = {
        let label = UILabel.createSpacingLabel(text: "회원을 탈퇴하면 모든 회원정보 및\n앨범과 사진이 삭제됩니다", size: 14, numberOfLines: 2)
        label.textAlignment = .center
        label.textColor = .gray
        return label
    }()
    
    private let notLeaveButton : UIButton = {
        let button = UIButton(frame: .zero)
        button.clipsToBounds = true
        button.layer.cornerRadius = 5
        button.titleLabel?.font = .boldSystemFont(ofSize: 14)
        button.setTitle("다시 생각해 볼게요", for: .normal)
        button.backgroundColor = .retroOrange
        return button
    }()
    
    private let leaveButton : UIButton = {
        let button = UIButton(frame: .zero)
        button.clipsToBounds = true
        button.layer.cornerRadius = 5
        button.titleLabel?.font = .boldSystemFont(ofSize: 14)
        button.setTitle("회원탈퇴", for: .normal)
        button.backgroundColor = .Cool_Lightgray
        return button
    }()
    
    private let signoutButton : UIButton = {
        let button = UIButton(frame: .zero)
        button.setTitle("회원탈퇴", for: .normal)
        button.tintColor = .gray
        button.titleLabel?.font = .systemFont(ofSize: 14)
        return button
    }()
    
    // MARK: - Properties
    
    enum SettingList: CaseIterable, CustomStringConvertible {
        case eventAlarm
        case logout
        
        var description: String {
            switch self {
            case .eventAlarm: return "마케팅 이벤트 알림"
            case .logout: return "로그아웃"
            }
        }
    }
    
    let viewModel: ProfileSettingViewModel
    
    init(viewModel: ProfileSettingViewModel) {
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("Could not use coder")
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        setUpSubviews()
        setUpTableView()
        setUpButtonEvent()
    }
 
    private func setUpSubviews() {
        navigationItem.title = "설정"
        
        view.addSubview(tableView)
        view.addSubview(signoutButton)
        view.addSubview(leaveView)
        
        leaveView.addSubview(leaveTitleLabel)
        leaveView.addSubview(leaveSubTitleLabel)
        leaveView.addSubview(notLeaveButton)
        leaveView.addSubview(leaveButton)
        
        tableView.snp.makeConstraints {
            $0.edges.equalTo(view.safeAreaLayoutGuide)
        }
        
        signoutButton.snp.makeConstraints {
            $0.height.equalTo(60)
            $0.left.right.bottom.equalTo(view.safeAreaLayoutGuide)
        }
        
        leaveView.snp.makeConstraints {
            $0.width.equalTo(312)
            $0.height.equalTo(320)
            $0.bottom.equalTo(view.safeAreaLayoutGuide)
            $0.centerX.equalToSuperview()
        }
        
        leaveTitleLabel.snp.makeConstraints {
            $0.top.equalTo(53)
            $0.centerX.equalToSuperview()
        }
        
        leaveSubTitleLabel.snp.makeConstraints {
            $0.top.equalTo(leaveTitleLabel.snp.bottom).offset(18)
            $0.centerX.equalToSuperview()
        }
        
        leaveButton.snp.makeConstraints {
            $0.height.equalTo(57)
            $0.left.equalTo(18)
            $0.right.bottom.equalTo(-18)
        }
        
        notLeaveButton.snp.makeConstraints {
            $0.height.equalTo(57)
            $0.left.equalTo(18)
            $0.right.equalTo(-18)
            $0.bottom.equalTo(leaveButton.snp.top).offset(-12)
        }
    }
    
    private func setUpTableView() {
        tableView.rx.setDelegate(self).disposed(by: disposeBag)
        
        Observable.just(SettingList.allCases).bind(to: tableView.rx.items(cellIdentifier: ProfileSettingTableViewCell.reuseIdentifier, cellType: ProfileSettingTableViewCell.self)) { [weak self] index, element, cell in
            switch element {
            case .eventAlarm:
                cell.bind(
                    viewModel: .init(title: element.description,
                                     switchObservable: self?.viewModel.output.isReceivingEvent,
                                     toggleSwitchPublisher: self?.viewModel.input.toggleReceivingEvent)
                )
            case .logout:
                cell.bind(viewModel: .init(title: element.description))
            }
            cell.selectionStyle = .none
        }.disposed(by: disposeBag)
    }
    
    private func setUpButtonEvent() {
        signoutButton.rx.tap
            .subscribe(onNext: { [weak self] in
                self?.leaveView.isHidden = false
            })
            .disposed(by: disposeBag)
        
        notLeaveButton.rx.tap
            .subscribe(onNext: { [weak self] in
                self?.leaveView.isHidden = true
            })
            .disposed(by: disposeBag)
        
        leaveButton.rx.tap
            .subscribe(onNext: { [weak self] in
                self?.navigationController?.present(ProfileLeaveViewController(), animated: true)
            })
            .disposed(by: disposeBag)
    }
}
