//
//  FilmListPrintTableViewCell.swift
//  90s
//
//  Created by 성다연 on 2021/03/18.
//

import UIKit
import SnapKit

final class FilmListPrintTableViewCell: UITableViewCell {
    private var printBackgroundView : UIView = {
        let view = UIView(frame: .zero)
        view.clipsToBounds = true
        view.layer.cornerRadius = 5
        view.backgroundColor = .warmGray
        return view
    }()
    
    private var filmImageView : UIImageView = {
        let iv = UIImageView(frame: .zero)
        return iv
    }()
    
    private var filmTypeLabel : UILabel = {
        let label = LabelType.normal_gray_13.create()
        return label
    }()
    
    private var printInfoLabel : UILabel = {
        let label = LabelType.bold_21.create()
        let paragraph = NSMutableParagraphStyle()
        paragraph.lineSpacing = 5.0
        let attribute = NSMutableAttributedString(string: "사진을 모두 채운\n필름이 있어요", attributes: [NSAttributedString.Key.paragraphStyle: paragraph])
        label.attributedText = attribute
        label.numberOfLines = 2
        label.textAlignment = .center
        return label
    }()
    
    var printButton : UIButton = {
        let btn = UIButton(frame: .zero)
        btn.backgroundColor = .retroOrange
        btn.setTitle("바로 인화하기", for: .normal)
        btn.titleLabel?.font = .boldSystemFont(ofSize: 14)
        btn.tintColor = .white
        btn.clipsToBounds = true
        btn.layer.cornerRadius = 5
        return btn
    }()
    
    static let cellID = "filmListPrintCell"
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setSubViews()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setSubViews() {
        addSubview(printBackgroundView)
        addSubview(filmImageView)
        addSubview(filmTypeLabel)
        addSubview(printInfoLabel)
        addSubview(printButton)
        
        backgroundColor = .black
        
        printBackgroundView.snp.makeConstraints {
            $0.left.top.equalTo(0).offset(18)
            $0.right.bottom.equalTo(0).offset(-18)
        }
        
        filmImageView.snp.makeConstraints {
            $0.width.equalTo(57)
            $0.height.equalTo(79)
            $0.top.equalTo(46)
            $0.centerX.equalTo(self.snp.centerX)
        }
        
        filmTypeLabel.snp.makeConstraints {
            $0.centerX.equalTo(self.snp.centerX)
            $0.top.equalTo(filmImageView.snp.bottom).offset(25)
        }
        
        printInfoLabel.snp.makeConstraints {
            $0.centerX.equalTo(self.snp.centerX)
            $0.top.equalTo(filmTypeLabel.snp.bottom).offset(10)
        }
        
        printButton.snp.makeConstraints {
            $0.height.equalTo(57)
            $0.left.equalTo(printBackgroundView.snp.left).offset(40)
            $0.right.equalTo(printBackgroundView.snp.right).offset(-40)
            $0.bottom.equalTo(printBackgroundView.snp.bottom).offset(-26)
        }
    }
    
    func bindViewModel(film: Film) {
        filmTypeLabel.text = film.filterType.rawValue
        
        DispatchQueue.main.async { [weak self] in
            self?.filmImageView.image = UIImage(named: film.filterType.image())
        }
    }
}
