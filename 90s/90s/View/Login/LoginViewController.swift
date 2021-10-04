//
//  LoginViewController.swift
//  90s
//
//  Created by woongs on 2021/10/02.
//

import UIKit

class LoginViewController: BaseViewController {
    
    // MARK: - Views
    
    fileprivate var buttonsStackView: UIStackView = {
        let stackView = UIStackView()
        stackView.distribution = .fillEqually
        stackView.spacing = 14
        stackView.axis = .vertical
        return stackView
    }()
    
    fileprivate var kakaoLoginButton: UIButton = {
        let button = UIButton()
        button.setTitle("카카오톡으로 로그인", for: .normal)
        button.setTitleColor(.black, for: .normal)
        button.backgroundColor = UIColor(hexString: "FEE233")
        button.addTarget(self, action: #selector(kakaoLoginDidTap(_:)), for: .touchUpInside)
        return button
    }()
    
    fileprivate var googleLoginButton: UIButton = {
        let button = UIButton()
        button.setTitle("구글로 로그인", for: .normal)
        button.setTitleColor(.black, for: .normal)
        button.backgroundColor = .white
        button.addTarget(self, action: #selector(googleLoginDidTap(_:)), for: .touchUpInside)
        return button
    }()
    
    fileprivate var appleLoginButton: UIButton = {
        let button = UIButton()
        button.setTitle("Apple로 로그인", for: .normal)
        button.setTitleColor(.white, for: .normal)
        button.backgroundColor = .Cool_Gray
        button.addTarget(self, action: #selector(appleLoginDidTap), for: .touchUpInside)
        return button
    }()

    override func viewDidLoad() {
        super.viewDidLoad()
        self.setupViews()
    }
    
    private func setupViews() {
        self.view.addSubview(buttonsStackView)
        let loginButtons = [kakaoLoginButton, googleLoginButton, appleLoginButton]
        let buttonLogos = ["kakao_logo", "google_logo", "apple_logo"].map { UIImage(named: $0) }
        
        self.buttonsStackView.snp.makeConstraints { maker in
            maker.leading.trailing.equalTo(self.view.safeAreaLayoutGuide).inset(18)
            maker.bottom.equalTo(self.view.safeAreaLayoutGuide).inset(75)
        }
        
        
        zip(loginButtons, buttonLogos).forEach { (button, logo) in
            self.buttonsStackView.addArrangedSubview(button)
            button.layer.cornerRadius = 8
            button.snp.makeConstraints { maker in
                maker.height.equalTo(57)
            }
            
            let logoImageView = UIImageView(image: logo)
            logoImageView.contentMode = .scaleAspectFit
            button.addSubview(logoImageView)
            logoImageView.snp.makeConstraints { maker in
                maker.leading.equalToSuperview().inset(18)
                maker.centerY.equalToSuperview()
                maker.width.height.equalTo(25)
            }
        }
    }
    
    @objc
    private func kakaoLoginDidTap(_ sender: UIButton) {
        
    }
    
    @objc
    private func googleLoginDidTap(_ sender: UIButton) {
        
    }
    
    @objc
    private func appleLoginDidTap(_ sender: UIButton) {
        
    }
}
