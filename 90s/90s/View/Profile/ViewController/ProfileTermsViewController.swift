//
//  ProfileTermsViewController.swift
//  90s
//
//  Created by 성다연 on 2021/07/02.
//

import UIKit

final class ProfileTermsViewController: BaseViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        setUpSubviews()
    }
    
    private func setUpSubviews(){
        navigationItem.title = "약관 개인정보 처리방침"
    }
}
