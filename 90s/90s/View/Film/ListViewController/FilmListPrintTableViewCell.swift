//
//  FilmListPrintTableViewCell.swift
//  90s
//
//  Created by 성다연 on 2021/03/18.
//

import UIKit
import RxSwift
import SnapKit

/// 필름 "인화할 시간!" 테이블 셀
final class FilmListPrintTableViewCell: UITableViewCell {
    private var printBackgroundView : UIView = {
        let view = UIView(frame: .zero)
        view.clipsToBounds = true
        view.layer.cornerRadius = 5
        view.backgroundColor = .Cool_Gray
        return view
    }()
    
    private var filmImageView : UIImageView = {
        let iv = UIImageView(frame: .zero)
        iv.contentMode = .scaleAspectFit
        return iv
    }()
    
    private var filmTypeLabel : UILabel = {
        let label = UILabel(frame: .zero)
        label.font = .Film_Sub_Title
        label.textColor = .gray
        return label
    }()
    
    private var printInfoLabel : UILabel = {
        let label = UILabel(frame: .zero)
        label.font = .Large_Text_Bold
        
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
    
    static let cellID = "FilmListPrintTableViewCell"
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setUpSubViews()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setUpSubViews() {
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
            $0.width.equalTo(67)
            $0.height.equalTo(105)
            $0.top.equalTo(printBackgroundView.snp.top).offset(20)
            $0.centerX.equalTo(printBackgroundView.snp.centerX)
        }
        
        filmTypeLabel.snp.makeConstraints {
            $0.centerX.equalTo(self.snp.centerX)
            $0.top.equalTo(filmImageView.snp.bottom).offset(4)
        }
        
        printInfoLabel.snp.makeConstraints {
            $0.centerX.equalTo(self.snp.centerX)
            $0.top.equalTo(filmTypeLabel.snp.bottom).offset(11)
        }
        
        printButton.snp.makeConstraints {
            $0.height.equalTo(57)
            $0.left.equalTo(printBackgroundView.snp.left).offset(40)
            $0.right.equalTo(printBackgroundView.snp.right).offset(-40)
            $0.bottom.equalTo(printBackgroundView.snp.bottom).offset(-26)
        }
    }
    
    func bindViewModel(film: Film) {
        filmTypeLabel.text = film.filmType.name.rawValue
        
        DispatchQueue.main.async { [weak self] in
            self?.filmImageView.image = UIImage(named: film.filmType.name.image)
        }
    }
}
