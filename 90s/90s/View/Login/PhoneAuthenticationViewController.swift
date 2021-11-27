//
//  PhoneAuthenticationViewController.swift
//  90s
//
//  Created by woongs on 2021/10/16.
//

import UIKit

class PhoneAuthenticationViewController: BaseViewController {
    
    // MARK: - Views
    
    private let phoneNumberTextField: LabelTextFieldView = {
        let textFieldView = LabelTextFieldView(label: "휴대폰 번호", placeholder: "010-1234-1234")
        textFieldView.label.textColor = .white
        textFieldView.underline.width = 1
        textFieldView.underline.color = .gray
        textFieldView.textField.setClearButton(with: UIImage(named: "icon_Delete_Text")!, mode: .whileEditing)
        return textFieldView
    }()
    
    private let authNumberView: UIView = {
        let view = UIView()
        view.isHidden = true
        return view
    }()
    
    private let authenticationTextField: LabelTextFieldView = {
        let textFieldView = LabelTextFieldView(label: "인증번호", placeholder: "인증번호 4자리 입력")
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
        self.viewModel = PhoneAuthenticationViewModel(dependency: .init())
        super.init(coder: coder)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.setupViews()
    }
    
    private func setupViews() {
        self.view.addSubview(self.phoneNumberTextField)
        self.view.addSubview(authNumberView)
        self.authNumberView.addSubview(self.authenticationTextField)
        self.authNumberView.addSubview(self.retryButton)
        self.view.addSubview(self.authenticationCompleteButton)
        
        self.phoneNumberTextField.snp.makeConstraints { maker in
            maker.top.equalTo(self.view.safeAreaLayoutGuide).offset(35)
            maker.leading.trailing.equalToSuperview()
            maker.height.equalTo(75)
        }
        self.authNumberView.snp.makeConstraints { maker in
            maker.top.equalTo(self.phoneNumberTextField.snp.bottom)
            maker.leading.trailing.equalToSuperview()
            maker.height.equalTo(75)
        }
        self.authenticationTextField.snp.makeConstraints { maker in
            maker.top.leading.bottom.equalToSuperview()
        }
        self.retryButton.snp.makeConstraints { maker in
            maker.trailing.equalToSuperview().inset(18)
            maker.leading.equalTo(self.authenticationTextField.snp.trailing)
            maker.height.equalTo(35)
            maker.width.equalTo(78)
            maker.centerY.equalToSuperview()
        }
        
        self.phoneNumberTextField.inset = .init(top: 15, left: 18, bottom: 15, right: 18)
        self.authenticationTextField.inset = .init(top: 15, left: 18, bottom: 15, right: 12)
        
        self.authenticationCompleteButton.snp.makeConstraints { maker in
            maker.top.equalTo(self.authNumberView.snp.bottom).offset(21)
            maker.leading.trailing.equalToSuperview().inset(18)
            maker.height.equalTo(57)
        }
    }
}
