//
//  StickerPackViewController.swift
//  90s
//
//  Created by woong on 2021/02/07.
//

import UIKit
import SnapKit

class StickerPackViewController: UIViewController {
    
    lazy var button: UIButton = {
        let button = UIButton()
        button.translatesAutoresizingMaskIntoConstraints = false
        button.setTitle("HELLO", for: .normal)
        button.addTarget(self, action: #selector(didTapButton(_:)), for: .touchUpInside)
        return button
    }()
    
    var tapHandler: (() -> Void)?

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .systemBlue
        
        view.addSubview(button)
        button.snp.makeConstraints {
            $0.center.equalTo(view.snp.center)
        }
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
    }
    
    @objc func didTapButton(_ sender: UIButton) {
        tapHandler?()
    }
}
