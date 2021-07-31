//
//  ProfileLeaveTableViewCell.swift
//  90s
//
//  Created by 성다연 on 2021/07/13.
//

import UIKit
import SnapKit

class ProfileLeaveTableViewCell: UITableViewCell {
    private let clickImageView : UIImageView = {
        let iv = UIImageView(frame: .zero)
        iv.image = UIImage(named: "film_edit_unselect")
        return iv
    }()
    
    private let titleLabel : UILabel = {
        let label = UILabel(frame: .zero)
        label.font = .Popup_Title
        return label
    }()
    
    static let cellID = "ProfileLeaveTableViewCell"
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setUpSubviews()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setUpSubviews() {
        addSubview(clickImageView)
        addSubview(titleLabel)
        
        backgroundColor = .black
        
        clickImageView.snp.makeConstraints {
            $0.height.width.equalTo(30)
            $0.left.equalTo(18)
            $0.centerY.equalToSuperview()
        }
        
        titleLabel.snp.makeConstraints {
            $0.left.equalTo(clickImageView.snp.right).offset(16)
            $0.centerY.equalToSuperview()
        }
    }
    
    func bindViewModel(text: String) {
        titleLabel.text = text
    }
    
    func changeImageView(isClicked: Bool) {
        DispatchQueue.main.async { [weak self] in
            switch isClicked {
            case true:
                self?.clickImageView.image = UIImage(named: "film_edit_select")
            case false:
                self?.clickImageView.image = UIImage(named: "film_edit_unselect")
            }
        }
    }
}
