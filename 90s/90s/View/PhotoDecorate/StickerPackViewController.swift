//
//  StickerPackViewController.swift
//  90s
//
//  Created by woong on 2021/02/07.
//

import UIKit

class StickerPackViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .green
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        navigationController?.setNavigationBarHidden(false, animated: true)
    }
}
