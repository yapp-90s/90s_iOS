//
//  ProfileLeaveViewController.swift
//  90s
//
//  Created by 성다연 on 2021/07/12.
//

import UIKit
import SnapKit
import RxSwift
import RxCocoa

final class ProfileLeaveViewController: BaseViewController {
    
    private let closeButton : UIButton = {
        let button = UIButton(frame: .zero)
        button.setImage(UIImage(named: "navigationBar_close"), for: .normal)
        return button
    }()
    
    private let titleLabel : UILabel = {
        return UILabel.createSpacingLabel(text: "탈퇴를 결심한 이유는\n무엇인가요?", size: 17, numberOfLines: 2)
    }()
    
    
    
    private let leaveButton : UIButton = {
        let button = UIButton(frame: .zero)
        button.backgroundColor = .Cool_Gray
        button.setTitle("회원탈퇴", for: .normal)
        button.titleLabel?.font = .boldSystemFont(ofSize: 15)
        button.clipsToBounds = true
        button.layer.cornerRadius = 5
        return button
    }()
    
    private var items = Observable.of([
        (false, "사용하기 어려워요"),
        (false, "흥미가 없어졌어요"),
        (false, "오류가 많아서 불편해요"),
        (false, "기타")
    ])

    override func viewDidLoad() {
        super.viewDidLoad()
        setUpSubviews()
        setUpButtonEvent()
    }
    
    private func setUpSubviews() {
        view.addSubview(closeButton)
        view.addSubview(titleLabel)
        view.addSubview(leaveButton)
        
        view.backgroundColor = .black
        
        closeButton.snp.makeConstraints {
            $0.width.height.equalTo(50)
            $0.right.equalTo(-18)
            $0.top.equalTo(view.safeAreaLayoutGuide).offset(18)
        }
        
        titleLabel.snp.makeConstraints {
            $0.left.equalTo(18)
            $0.top.equalTo(closeButton).offset(47)
        }
        
        leaveButton.snp.makeConstraints {
            $0.height.equalTo(57)
            $0.left.equalTo(18)
            $0.right.equalTo(-18)
            $0.bottom.equalTo(view.safeAreaLayoutGuide).offset(-250)
        }
    }
    
    private func setUpButtonEvent() {
        closeButton.rx.tap.bind {
            self.dismiss(animated: true, completion: nil)
        }.disposed(by: disposeBag)
        
        leaveButton.rx.tap.bind {
            
        }.disposed(by: disposeBag)
    }
}
