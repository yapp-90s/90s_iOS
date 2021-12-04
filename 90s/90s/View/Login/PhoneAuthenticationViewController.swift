//
//  PhoneAuthenticationViewController.swift
//  90s
//
//  Created by woongs on 2021/10/16.
//

import UIKit

class PhoneAuthenticationViewController: BaseViewController {
    
    // MARK: - Views
    
    private let phoneNumberTextFieldView: LabelTextFieldView = {
        let textFieldView = LabelTextFieldView(label: "휴대폰 번호", placeholder: "01012341234")
        textFieldView.label.textColor = .white
        textFieldView.underline.width = 1
        textFieldView.underline.color = .gray
        textFieldView.textField.setClearButton(with: UIImage(named: "icon_Delete_Text")!, mode: .whileEditing)
        textFieldView.textField.keyboardType = .numberPad
        return textFieldView
    }()
    
    private let authNumberView: UIView = {
        let view = UIView()
        view.isHidden = true
        return view
    }()
    
    private let authenticationTextFieldView: LabelTextFieldView = {
        let textFieldView = LabelTextFieldView(label: "인증번호", placeholder: "인증번호 6자리 입력")
        textFieldView.labelTrailingSpacing = 48
        textFieldView.label.textColor = .white
        textFieldView.underline.width = 1
        textFieldView.underline.color = .gray
        textFieldView.textField.setClearButton(with: UIImage(named: "icon_Delete_Text")!, mode: .whileEditing)
        return textFieldView
    }()
    
    private let retryButton: UIButton = {
        let button = UIButton()
        button.setTitle("재전송", for: .normal)
        button.setTitleColor(.white, for: .normal)
        button.titleLabel?.font = .Small_Text_Bold
        button.backgroundColor = .Cool_Gray
        button.layer.cornerRadius = 6
        return button
    }()
    
    private let authenticationCompleteButton: UIButton = {
        let button = UIButton()
        button.setTitle("인증번호 받기", for: .normal)
        button.setTitleColor(.white, for: .normal)
        button.backgroundColor = .Cool_Gray
        button.layer.cornerRadius = 6
        button.isEnabled = false
        return button
    }()
    
    // MARK: - View Life Cycle
    
    let viewModel: PhoneAuthenticationViewModel
    
    init(viewModel: PhoneAuthenticationViewModel) {
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        self.viewModel = PhoneAuthenticationViewModel(dependency: .init(loginService: LoginService()))
        super.init(coder: coder)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.setupViews()
        self.bind()
    }
    
    private func setupViews() {
        self.title = "휴대폰 번호 인증"
        self.view.addSubview(self.phoneNumberTextFieldView)
        self.view.addSubview(authNumberView)
        self.authNumberView.addSubview(self.authenticationTextFieldView)
        self.authNumberView.addSubview(self.retryButton)
        self.view.addSubview(self.authenticationCompleteButton)
        
        self.phoneNumberTextFieldView.snp.makeConstraints { maker in
            maker.top.equalTo(self.view.safeAreaLayoutGuide).offset(35)
            maker.leading.trailing.equalToSuperview()
            maker.height.equalTo(75)
        }
        self.authNumberView.snp.makeConstraints { maker in
            maker.top.equalTo(self.phoneNumberTextFieldView.snp.bottom)
            maker.leading.trailing.equalToSuperview()
            maker.height.equalTo(75)
        }
        self.authenticationTextFieldView.snp.makeConstraints { maker in
            maker.top.leading.bottom.equalToSuperview()
        }
        self.retryButton.snp.makeConstraints { maker in
            maker.trailing.equalToSuperview().inset(18)
            maker.leading.equalTo(self.authenticationTextFieldView.snp.trailing)
            maker.height.equalTo(35)
            maker.width.equalTo(78)
            maker.centerY.equalToSuperview()
        }
        
        self.phoneNumberTextFieldView.inset = .init(top: 15, left: 18, bottom: 15, right: 18)
        self.authenticationTextFieldView.inset = .init(top: 15, left: 18, bottom: 15, right: 12)
        
        self.authenticationCompleteButton.snp.makeConstraints { maker in
            maker.top.equalTo(self.authNumberView.snp.bottom).offset(21)
            maker.leading.trailing.equalToSuperview().inset(18)
            maker.height.equalTo(57)
        }
    }
    
    private func bind() {
        
        // Input
        self.phoneNumberTextFieldView.textField.rx.text.orEmpty
            .distinctUntilChanged()
            .bind(to: self.viewModel.input.phoneNumberChanged)
            .disposed(by: self.disposeBag)
        self.authenticationTextFieldView.textField.rx.text.orEmpty
            .distinctUntilChanged()
            .bind(to: self.viewModel.input.responseNumberChanged)
            .disposed(by: self.disposeBag)
        
        
        self.authenticationCompleteButton.rx.tap
            .bind(to: self.viewModel.input.completeButtonDidTap)
            .disposed(by: self.disposeBag)
        
        // Output
        self.viewModel.output.authenticationStep
            .subscribe(onNext: { [weak self] step in
                let (completeButtonText, isEnabled): (String, Bool)
                switch step {
                case .enterPhoneNumber:
                    (completeButtonText, isEnabled) = ("인증번호 받기", false)
                case .requestAuthenticationSms:
                    (completeButtonText, isEnabled) = ("인증번호 받기", true)
                case .responseAuthenticationSms:
                    (completeButtonText, isEnabled) = ("인증 완료", false)
                case .completeAuthentication:
                    (completeButtonText, isEnabled) = ("인증 완료", true)
                }
                
                self?.authenticationCompleteButton.setTitle(completeButtonText, for: .normal)
                self?.authenticationCompleteButton.isEnabled = isEnabled
                self?.authenticationCompleteButton.backgroundColor = isEnabled ? .retroOrange : .Cool_Gray
            })
            .disposed(by: self.disposeBag)
        
        self.viewModel.output.isHiddenAuthenticationTextField
            .bind(to: self.authNumberView.rx.isHidden)
            .disposed(by: self.disposeBag)
    }
    
    private func updateCompleButton(isEnabled: Bool) {
        self.authenticationCompleteButton.isEnabled = isEnabled
        self.authenticationCompleteButton.backgroundColor = isEnabled ? .retroOrange : .Cool_Gray
    }
}
