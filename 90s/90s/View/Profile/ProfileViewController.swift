//
//  ProfileViewController.swift
//  90s
//
//  Created by 성다연 on 2021/06/28.
//

import UIKit
import SnapKit
import RxSwift
import RxCocoa

final class ProfileViewController: BaseViewController, UIScrollViewDelegate {

    // MARK: - UI Component
    
    private let profileView : UIView = {
        let v = UIView(frame: .zero)
        return v
    }()
    
    private let imageView : UIImageView = {
        let iv = UIImageView(frame: .zero)
        iv.clipsToBounds = true
        iv.layer.cornerRadius = 38
        iv.backgroundColor = .gray
        return iv
    }()
    
    private let nameLabel : UILabel = {
        let label = UILabel(frame: .zero)
        label.font = .Film_Title
        label.text = "User Name"
        return label
    }()
    
    private let emailLabel : UILabel = {
        let label = UILabel(frame: .zero)
        label.font = .Film_Sub_Title
        label.text = "aaaabbbb@90s.com"
        return label
    }()
    
    private let informationView : UIView = {
        let v = UIView(frame: .zero)
        return v
    }()
    
    private let albumCountLabel : UILabel = {
        let label = UILabel(frame: .zero)
        label.font = .Large_Text
        label.text = "n개"
        return label
    }()
    
    private let photoCountLabel : UILabel = {
        let label = UILabel(frame: .zero)
        label.font = .Large_Text
        label.text = "n장"
        return label
    }()
    
    private let filmCountLabel : UILabel = {
        let label = UILabel(frame: .zero)
        label.font = .Large_Text
        label.text = "n통"
        return label
    }()
    
    private let albumInfoLabel: UILabel = {
        let label = UILabel(frame: .zero)
        label.font = .Film_Sub_Title
        label.text = "앨범"
        return label
    }()
    
    private let photoInfoLabel: UILabel = {
        let label = UILabel(frame: .zero)
        label.font = .Film_Sub_Title
        label.text = "사진"
        return label
    }()
    
    private let filmInfoLabel: UILabel = {
        let label = UILabel(frame: .zero)
        label.font = .Film_Sub_Title
        label.text = "필름"
        return label
    }()
    
    private let albumPointView : UIView = {
        let v = UIView(frame: .zero)
        v.backgroundColor = .retroOrange
        v.clipsToBounds = true
        v.layer.cornerRadius = 2
        return v
    }()
    
    private let photoPointView : UIView = {
        let v = UIView(frame: .zero)
        v.backgroundColor = .retroOrange
        v.clipsToBounds = true
        v.layer.cornerRadius = 2
        return v
    }()
  
    private let filmPointView : UIView = {
        let v = UIView(frame: .zero)
        v.backgroundColor = .retroOrange
        v.clipsToBounds = true
        v.layer.cornerRadius = 2
        return v
    }()
    
    private let tableView: UITableView = {
        let tv = UITableView(frame: .zero)
        tv.separatorStyle = .none
        tv.showsHorizontalScrollIndicator = false
        tv.rowHeight = 65
        tv.isScrollEnabled = false
        
        tv.register(reusable: ProfileMainTableViewCell.self)
        return tv
    }()
    
    private let manageButton: UIButton = {
        let btn = UIButton(frame: .zero)
        btn.setTitleColor(.lightGray, for: .normal)
        btn.titleLabel?.font = .systemFont(ofSize: 14)
        btn.setTitle("프로필 관리", for: .normal)
        return btn
    }()
    
    // MARK: - Properties
    
    enum SettingList: CaseIterable, CustomStringConvertible {
        case setting
        case faq
        case privacyPolicyTerms
        
        var description: String {
            switch self {
            case .setting: return "설정"
            case .faq: return "자주 묻는 질문"
            case .privacyPolicyTerms: return "약관 · 개인정보 처리방침"
            }
        }
    }
    
    let viewModel: ProfileViewModel
    
    // MARK: - LifeCycle
    
    init(viewModel: ProfileViewModel) {
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setUpSubviews()
        setUpTableView()
        setUpManageButton()
        bind()
    }
    
    private func setUpSubviews() {
        view.backgroundColor = .black
        
        view.addSubview(profileView)
        view.addSubview(informationView)
        view.addSubview(tableView)
        view.addSubview(manageButton)
        
        profileView.addSubview(imageView)
        profileView.addSubview(nameLabel)
        profileView.addSubview(emailLabel)
        
        informationView.addSubview(albumCountLabel)
        informationView.addSubview(albumInfoLabel)
        informationView.addSubview(albumPointView)
        informationView.addSubview(photoCountLabel)
        informationView.addSubview(photoInfoLabel)
        informationView.addSubview(photoPointView)
        informationView.addSubview(filmCountLabel)
        informationView.addSubview(filmInfoLabel)
        informationView.addSubview(filmPointView)
        
        let safe = view.safeAreaLayoutGuide
        
        profileView.snp.makeConstraints {
            $0.top.left.right.equalTo(safe)
            $0.height.equalTo(160)
        }
        
        informationView.snp.makeConstraints {
            $0.top.equalTo(profileView.snp.bottom).offset(11)
            $0.left.right.equalToSuperview()
            $0.height.equalTo(110)
        }
        
        // Setting ProfileView
        
        imageView.snp.makeConstraints {
            $0.top.equalTo(13)
            $0.centerX.equalTo(view.snp.centerX)
            $0.width.height.equalTo(78)
        }
        
        nameLabel.snp.makeConstraints {
            $0.top.equalTo(imageView.snp.bottom).offset(12)
            $0.centerX.equalTo(view.snp.centerX)
        }
        
        emailLabel.snp.makeConstraints {
            $0.top.equalTo(nameLabel.snp.bottom).offset(5)
            $0.centerX.equalTo(view.snp.centerX)
        }
        
        // Setting informationView
        
        informationView.snp.makeConstraints {
            $0.height.equalTo(110)
            $0.top.equalTo(profileView.snp.bottom).offset(11)
            $0.left.right.equalTo(safe)
        }
        
        photoCountLabel.snp.makeConstraints {
            $0.top.equalTo(32)
            $0.centerX.equalTo(informationView.snp.centerX)
        }
        
        photoInfoLabel.snp.makeConstraints {
            $0.top.equalTo(photoCountLabel.snp.bottom).offset(8)
            $0.centerX.equalTo(informationView.snp.centerX)
        }
        
        photoPointView.snp.makeConstraints {
            $0.width.height.equalTo(4)
            $0.left.equalTo(photoCountLabel.snp.right).offset(3)
            $0.top.equalTo(photoCountLabel.snp.top)
        }
        
        albumCountLabel.snp.makeConstraints {
            $0.top.equalTo(32)
            $0.left.equalTo(60)
        }
        
        albumInfoLabel.snp.makeConstraints {
            $0.top.equalTo(albumCountLabel.snp.bottom).offset(8)
            $0.left.equalTo(60)
        }
        
        albumPointView.snp.makeConstraints {
            $0.width.height.equalTo(4)
            $0.top.equalTo(albumCountLabel.snp.top)
            $0.left.equalTo(albumCountLabel.snp.right).offset(3)
        }
        
        filmCountLabel.snp.makeConstraints {
            $0.top.equalTo(32)
            $0.right.equalTo(-60)
        }
        
        filmInfoLabel.snp.makeConstraints {
            $0.top.equalTo(filmCountLabel.snp.bottom).offset(8)
            $0.right.equalTo(-60)
        }
        
        filmPointView.snp.makeConstraints {
            $0.width.height.equalTo(4)
            $0.top.equalTo(filmCountLabel.snp.top)
            $0.left.equalTo(filmCountLabel.snp.right).offset(3)
        }
        
        // Setting tableView
        
        tableView.snp.makeConstraints {
            $0.top.equalTo(informationView.snp.bottom).offset(6)
            $0.left.right.equalTo(safe)
            $0.height.equalTo(200)
        }
        
        manageButton.snp.makeConstraints {
            $0.top.equalTo(tableView.snp.bottom).offset(22)
            $0.left.right.equalTo(safe)
            $0.height.equalTo(60)
        }
    }
    
    private func setUpTableView() {
        tableView.rx.setDelegate(self).disposed(by: disposeBag)
        
        Observable.just(SettingList.allCases).bind(to: tableView.rx.items(cellIdentifier: ProfileMainTableViewCell.reuseIdentifier, cellType: ProfileMainTableViewCell.self)) { index, settingList, cell in
            cell.configure(title: settingList.description)
            cell.selectionStyle = .none
        }.disposed(by: disposeBag)
        
        tableView.rx.modelSelected(SettingList.self).subscribe(onNext: { item in
            switch item {
            case .setting :
                self.navigationController?.pushViewController(ProfileSettingViewController(), animated: true)
            case .faq:
                self.navigationController?.pushViewController(ProfileFAQViewController(), animated: true)
            case .privacyPolicyTerms:
                self.navigationController?.pushViewController(ProfileTermsViewController(), animated: true)
            }
        }).disposed(by: disposeBag)
    }
    
    private func setUpManageButton() {
        manageButton.rx.tap.bind {
            self.navigationController?.pushViewController(ProfileEditViewController(), animated: true)
        }.disposed(by: disposeBag)
    }
    
    private func bind() {
        // output
        self.viewModel.output.albumCount
            .map { "\($0)개" }
            .bind(to: albumCountLabel.rx.text)
            .disposed(by: self.disposeBag)
        
        self.viewModel.output.photoCount
            .map { "\($0)장" }
            .bind(to: photoCountLabel.rx.text)
            .disposed(by: self.disposeBag)
        
        self.viewModel.output.filmCount
            .map { "\($0)통" }
            .bind(to: filmCountLabel.rx.text)
            .disposed(by: self.disposeBag)
    }
}
