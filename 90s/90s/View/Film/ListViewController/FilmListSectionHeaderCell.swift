//
//  FilmListSectionHeaderCell.swift
//  90s
//
//  Created by 성다연 on 2021/02/23.
//

import UIKit
import SnapKit

/// 필름 섹션 안내 문구 테이블 셀
final class FilmListSectionHeaderCell: UITableViewHeaderFooterView {
    private var headerTitle : UILabel = {
        let label = UILabel(frame: .zero)
        label.font = .Head
        return label
    }()
    
    private var blackView : UILabel = {
        let label = UILabel(frame: .zero)
        label.backgroundColor = .gray
        label.isHidden = true
        return label
    }()
    
    override init(reuseIdentifier: String?) {
        super.init(reuseIdentifier: reuseIdentifier)
        setUpSubView()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setUpSubView(){
        addSubview(headerTitle)
        addSubview(blackView)
        
        headerTitle.snp.makeConstraints {
            $0.left.equalTo(18)
            $0.bottom.equalTo(-12)
        }
        
        blackView.snp.makeConstraints {
            $0.height.top.equalTo(1)
            $0.left.equalTo(18)
            $0.right.equalTo(-18)
        }
    }
    
    func bindViewModel(text: String){
        headerTitle.text = text
    }
    
    func bindBlackView(hidden: Bool){
        blackView.isHidden = hidden
    }
}
