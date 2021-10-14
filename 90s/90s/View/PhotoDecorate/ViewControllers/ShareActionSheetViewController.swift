//
//  ShareActionSheetViewController.swift
//  90s
//
//  Created by kakao on 2021/09/18.
//

import UIKit

class ShareActionSheetViewController: ActionSheetViewController {
    
    // MARK: - Views
    
    private let shareButtonStackView: UIStackView = {
        let stackView = UIStackView()
        stackView.axis = .horizontal
        stackView.distribution = .fillEqually
        stackView.spacing = 30
        return stackView
    }()
    
    private let kakaoShareButton: UIButton = {
        let button = UIButton()
        button.setImage(UIImage(named: "logo_circle_kakaotalk"), for: .normal)
        return button
    }()
    
    private let instagramShareButton: UIButton = {
        let button = UIButton()
        button.setImage(UIImage(named: "logo_circle_instagram"), for: .normal)
        return button
    }()
    
    private let facebookShareButton: UIButton = {
        let button = UIButton()
        button.setImage(UIImage(named: "logo_circle_facebook"), for: .normal)
        return button
    }()

    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.setupViews()
    }
    
    private func setupViews() {
        self.actionSheetHeight = 160
        
        self.actionSheetContentView.addSubview(self.shareButtonStackView)
        [self.kakaoShareButton, self.instagramShareButton, self.facebookShareButton].forEach { button in
            self.shareButtonStackView.addArrangedSubview(button)
        }
        
        self.shareButtonStackView.snp.makeConstraints { maker in
            maker.top.equalToSuperview().offset(40)
            maker.centerX.equalToSuperview()
        }
    }
}
