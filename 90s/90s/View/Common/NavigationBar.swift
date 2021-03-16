//
//  NavigationBar.swift
//  90s
//
//  Created by 성다연 on 2021/03/16.
//

import UIKit
import SnapKit

class NavigationBar: UIView {
    var leftBtn : UIButton = {
        let btn = UIButton(frame: .zero)
        btn.setImage(UIImage(named: "navigate_back"), for: .normal)
        return btn
    }()
    
    var titleLabel : UILabel = {
        return LabelType.normal_16.create()
    }()
    
    var rightBtn: UIButton = {
        let btn = UIButton(frame: .zero)
        return btn
    }()
   
    override init(frame: CGRect) {
        super.init(frame: frame)
        setSubViews()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setSubViews(){
        leftBtn.snp.makeConstraints {
            $0
        }
    }
}
