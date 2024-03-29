//
//  ProfileEditViewController.swift
//  90s
//
//  Created by 성다연 on 2021/07/02.
//

import UIKit
import SnapKit
import RxSwift

final class ProfileEditViewController: BaseViewController {
    
    private let profileImageView : UIImageView = {
        let iv = UIImageView(frame: .zero)
        iv.clipsToBounds = true
        iv.backgroundColor = .gray
        iv.layer.cornerRadius = 38
        return iv
    }()
    
    private var nameTextField : UITextField = {
        let tf = UITextField(frame: .zero)
        tf.placeholder = "김구공"
        tf.clearButtonMode = .whileEditing
        tf.textAlignment = .center
        tf.font = .boldSystemFont(ofSize: 20)
        return tf
    }()
    
    private let underLineLabel : UILabel = {
        let label = UILabel(frame: .zero)
        label.backgroundColor = .lightGray
        return label
    }()
    
    private let editButton : UIButton = {
        let button = UIButton(frame: .zero)
        button.setTitle("수정하기", for: .normal)
        button.backgroundColor = .colorRGBHex(hex: 0x2E2F33)
        button.clipsToBounds = true
        button.layer.cornerRadius = 5
        return button
    }()
    
    private var name : String = ""
    private let viewModel: ProfileEditViewModel
    
    init(viewModel: ProfileEditViewModel) {
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setUpSubviews()
        bind()
    }
    
    private func setUpSubviews() {
        view.backgroundColor = .black
        
        view.addSubview(profileImageView)
        view.addSubview(nameTextField)
        view.addSubview(underLineLabel)
        view.addSubview(editButton)
        
        let safe = view.safeAreaLayoutGuide
    
        profileImageView.snp.makeConstraints {
            $0.top.equalTo(safe).offset(13)
            $0.height.width.equalTo(78)
            $0.centerX.equalTo(view.snp.centerX)
        }
        
        nameTextField.snp.makeConstraints {
            $0.left.equalTo(18)
            $0.right.equalTo(-18)
            $0.top.equalTo(profileImageView.snp.bottom).offset(35)
        }
        
        underLineLabel.snp.makeConstraints {
            $0.centerX.equalTo(view.snp.centerX)
            $0.top.equalTo(nameTextField.snp.bottom).offset(10)
            $0.height.equalTo(1)
            $0.width.equalTo(view.snp.width).offset(-36)
        }
        
        editButton.snp.makeConstraints {
            $0.top.equalTo(nameTextField.snp.bottom).offset(35)
            $0.centerX.equalTo(view.snp.centerX)
            $0.height.equalTo(60)
            $0.width.equalTo(view.snp.width).offset(-36)
        }
    }

    private func bind() {
        // input
        self.nameTextField.rx.value.orEmpty
            .bind(to: self.viewModel.input.nameStream)
            .disposed(by: self.disposeBag)
        
        self.editButton.rx.tap
            .bind(to: self.viewModel.input.editPublisher)
            .disposed(by: self.disposeBag)
        
        // output
        self.viewModel.output.nameObservable
            .map { $0.isEmpty == false }
            .subscribe(onNext: { [weak self] isActivate in
                self?.updateTextField(isActivated: isActivate)
            })
            .disposed(by: self.disposeBag)
        
        self.viewModel.output.profileImageObservable
            .map { UIImage(data: $0) }
            .bind(to: profileImageView.rx.image)
            .disposed(by: self.disposeBag)
        
        self.viewModel.output.editCompleteObservable
            .subscribe(onNext: { [weak self] _ in
                self?.navigationController?.popViewController(animated: true)
            })
            .disposed(by: self.disposeBag)
    }
    
    private func updateTextField(isActivated: Bool) {
        if isActivated {
            self.editButton.backgroundColor = .retroOrange
            self.editButton.isEnabled = true
        } else {
            self.editButton.backgroundColor = .warmGray
            self.editButton.isEnabled = false
        }
    }
}
