//
//  FilmListSectionHeaderCell.swift
//  90s
//
//  Created by 성다연 on 2021/02/23.
//

import UIKit
import SnapKit

final class FilmListSectionHeaderCell: UITableViewHeaderFooterView {
    private var headerTitle : UILabel = {
        return LabelType.bold_21.create()
    }()
    
    private var blackView : UILabel = {
        let label = UILabel(frame: .zero)
        label.backgroundColor = .gray
        label.isHidden = true
        return label
    }()
    
    static let cellID = "FilmListSectionHeaderCell"

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
