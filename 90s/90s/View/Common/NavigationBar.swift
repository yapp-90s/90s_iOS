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
        btn.imageEdgeInsets = UIEdgeInsets(top: 9, left: 9, bottom: 9, right: 9)
        return btn
    }()
    
    var titleLabel : UILabel = {
        let label = LabelType.normal_16.create()
        label.text = "Title"
        return label
    }()
    
    /// rightBtn.setUpNavBarRightBtn(type: NavBarRightBtn) 로 설정하세요!
    var rightBtn: UIButton = {
        return UIButton(frame: .zero)
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setSubViews()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setSubViews(){
        addSubview(leftBtn)
        addSubview(titleLabel)
        addSubview(rightBtn)
        
        leftBtn.snp.makeConstraints {
            $0.height.width.equalTo(52)
            $0.left.top.equalTo(self)
        }
        
        rightBtn.snp.makeConstraints {
            $0.height.equalTo(52)
            $0.width.equalTo(70)
            $0.top.right.equalTo(self)
        }
        
        titleLabel.snp.makeConstraints {
            $0.centerX.centerY.equalTo(self)
        }
    }
}
