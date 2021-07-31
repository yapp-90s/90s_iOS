//
//  FilmPopupView.swift
//  90s
//
//  Created by 성다연 on 2021/03/18.
//

import UIKit
import SnapKit

final class FilmPopupView: UIView {
    private var backgroundView : UIView = {
        let view = UIView(frame: .zero)
        view.backgroundColor = UIColor.black.withAlphaComponent(0.8)
        return view
    }()
    
    var popupView : UIView = {
        let view = UIView(frame: .zero)
        view.backgroundColor = .warmGray
        view.clipsToBounds = true
        view.layer.cornerRadius = 10
        return view
    }()
    
    var imageView : UIImageView = {
        let iv = UIImageView(frame: .zero)
        iv.image = UIImage(named: "icon_trash")
        return iv
    }()
    
    var titleLabel : UILabel = {
        let label = UILabel(frame: .zero)
        label.font = .Popup_Title
        label.text = "필름을 정말 삭제하시겠습니까?"
        return label
    }()
    
    var leftBtn : UIButton = {
        let btn = UIButton(frame: .zero)
        btn.setTitle("취소", for: .normal)
        btn.backgroundColor = .warmLightgray
        btn.clipsToBounds = true
        btn.layer.cornerRadius = 8
        return btn
    }()
    
    var rightBtn : UIButton = {
        let btn = UIButton(frame: .zero)
        btn.setTitle("삭제하기", for: .normal)
        btn.backgroundColor = .retroOrange
        btn.clipsToBounds = true
        btn.layer.cornerRadius = 8
        return btn
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setUpSubviews()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setUpSubviews(){
        addSubview(backgroundView)
        addSubview(popupView)
        
        popupView.addSubview(imageView)
        popupView.addSubview(titleLabel)
        popupView.addSubview(leftBtn)
        popupView.addSubview(rightBtn)
        
        backgroundView.snp.makeConstraints {
            $0.edges.equalTo(self)
        }
        
        popupView.snp.makeConstraints {
            $0.height.equalTo(222)
            $0.width.equalTo(311)
            $0.center.equalTo(self.snp.center)
        }
        
        imageView.snp.makeConstraints {
            $0.height.width.equalTo(59)
            $0.top.equalTo(24)
            $0.centerX.equalTo(self.snp.centerX)
        }
        
        titleLabel.snp.makeConstraints {
            $0.top.equalTo(imageView.snp.bottom).offset(13)
            $0.centerX.equalTo(self.snp.centerX)
        }
        
        leftBtn.snp.makeConstraints {
            $0.top.equalTo(titleLabel.snp.bottom).offset(28)
            $0.left.equalTo(18)
            $0.width.equalTo(132)
            $0.height.equalTo(57)
        }
        
        rightBtn.snp.makeConstraints {
            $0.top.equalTo(titleLabel.snp.bottom).offset(28)
            $0.right.equalTo(-18)
            $0.width.equalTo(132)
            $0.height.equalTo(57)
        }
    }
}
