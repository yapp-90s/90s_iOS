//
//  FilmListCollectionViewCell.swift
//  90s
//
//  Created by 성다연 on 2021/02/20.
//

import UIKit
import SnapKit
import RxSwift
import RxCocoa

/// 필름 리스트를 보여주는 테이블 셀
final class FilmListTableViewCell: UITableViewCell {
    private var filmTitleLabel : UILabel = {
        let label = UILabel(frame: .zero)
        label.font = .Film_Title
        return label
    }()
    
    private var filmCount_DateLabel : UILabel = {
        let label = UILabel(frame: .zero)
        label.font = .Film_Sub_Title
        return label
    }()
    
    /// 필름 상태를 보여주는 이미지 뷰
    private var filmTypeImageView : UIImageView = {
        let iv = UIImageView(frame: .zero)
        iv.contentMode = .scaleAspectFit
        return iv
    }()
    
    /// 필름 대표 이미지 뷰
    private var filmTitleImageView : UIImageView = {
        let iv = UIImageView(frame: .zero)
        return iv
    }()
    
    /// 필름 배경 이미지 뷰
    private var filmBackgroudImageView : UIImageView = {
        let iv = UIImageView(frame: .zero)
        iv.image = UIImage(named: "film_preview_roll")
        return iv
    }()
    
    private var filmNewLabel : UIButton = {
        let btn = UIButton(frame: .zero)
        btn.setTitle("NEW", for: .normal)
        btn.titleLabel?.font = .boldSystemFont(ofSize: 9)
        btn.tintColor = .white
        btn.backgroundColor = .retroOrange
        btn.clipsToBounds = true
        btn.layer.cornerRadius = 8
        btn.titleEdgeInsets = UIEdgeInsets(top: 0, left: 4, bottom: 0, right: 4)
        btn.isHidden = true
        return btn
    }()
    
    private var separateLine : UILabel = {
        let label = UILabel(frame: .zero)
        label.backgroundColor = .warmLightgray
        label.isHidden = true
        return label
    }()
    
    /// 필름 삭제 선택 버튼
    private var filmDeleteButton : UIButton = {
        let btn = UIButton(frame: .zero)
        btn.setImage(UIImage(named: "film_edit_unselect"), for: .normal)
        btn.backgroundColor = .black
        btn.isHidden = true
        return btn
    }()
    
    // MARK: - Property
    
    static let cellId = "filmListCell"
    
    private var disposeBag = DisposeBag()
    private var testFilmValue : (Film, Bool)?
    private var isDeleteBtnClicked : Bool = false
    private var imageViewArray : [UIImageView] = [
        .init(frame: .zero), .init(frame: .zero), .init(frame: .zero), .init(frame: .zero)]
    
    // MARK: - Initialize
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setUpSubViews()
    }

    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func prepareForReuse() {
        filmDeleteButton.setImage(UIImage(named: "film_edit_unselect"), for: .normal)
        imageViewArray.forEach { $0.image = nil }
    }
    
    // MARK: - Methods

    private func setUpSubViews(){
        addSubview(filmBackgroudImageView)
        addSubview(filmTitleImageView)
        
        addSubview(filmTitleLabel)
        addSubview(filmCount_DateLabel)
        addSubview(filmTypeImageView)
        addSubview(filmNewLabel)
        addSubview(separateLine)
        addSubview(filmDeleteButton)
        
        imageViewArray.forEach { addSubview($0) }
        
        backgroundColor = .clear
        
        filmTitleImageView.snp.makeConstraints {
            $0.width.equalTo(100)
            $0.height.equalTo(140)
            $0.left.equalTo(18)
            $0.top.equalTo(18)
        }
        
        filmBackgroudImageView.snp.makeConstraints {
            $0.left.equalTo(filmTitleImageView.snp.right).offset(-2)
            $0.height.equalTo(110)
            $0.right.equalTo(-28)
            $0.top.equalTo(32)
        }
        
        filmTitleLabel.snp.makeConstraints {
            $0.left.equalTo(20)
            $0.top.equalTo(filmTitleImageView.snp.bottom).offset(8)
        }
        
        filmCount_DateLabel.snp.makeConstraints {
            $0.left.equalTo(20)
            $0.top.equalTo(filmTitleLabel.snp.bottom).offset(2)
        }
        
        filmTypeImageView.snp.makeConstraints {
            $0.height.equalTo(29)
            $0.width.equalTo(105)
            $0.top.equalTo(filmBackgroudImageView.snp.bottom).offset(23)
            $0.right.equalTo(-18)
        }
        
        filmNewLabel.snp.makeConstraints {
            $0.width.equalTo(37)
            $0.height.equalTo(18)
            $0.top.equalTo(filmTitleImageView.snp.bottom).offset(9)
            $0.left.equalTo(filmTitleLabel.snp.right).offset(5)
        }
        
        separateLine.snp.makeConstraints {
            $0.height.equalTo(1)
            $0.top.equalTo(filmCount_DateLabel.snp.bottom).offset(25)
            $0.left.equalTo(18)
            $0.right.equalTo(-18)
        }
        
        filmDeleteButton.snp.makeConstraints {
            $0.width.equalTo(60)
            $0.height.equalTo(140)
            $0.centerY.equalTo(filmBackgroudImageView.snp.centerY)
            $0.right.equalTo(0)
        }
        
        imageViewArray.forEach { $0.snp.makeConstraints {
            $0.height.equalTo(80)
            $0.centerY.equalTo(filmTitleImageView.snp.centerY)
        }}
    }
    
    func bindViewModel(film: Film, isCreate: Bool){
        testFilmValue = (film, isCreate)
        
        DispatchQueue.main.async { [weak self] in
            self?.filmTitleImageView.image = UIImage(named: film.filmType.name.image)
            self?.filmTypeImageView.image = UIImage(named: film.state.image())
            self?.createInsideImages(type: film.filmType.name, photo: film.photos)
        }
        
        filmTitleLabel.text = film.name
        separateLine.isHidden = !isCreate
        
        switch isCreate {
        case true:
            filmTypeImageView.isHidden = true
            filmNewLabel.isHidden = true
            filmCount_DateLabel.text = "\(film.count)장 · 인화 \(film.filmType.name.printDaysCount)시간 소요"
        case false:
            filmCount_DateLabel.text = "\(film.count)/\(film.maxCount) · \(film.createdAt)" // 전체 개수 리턴하는 함수 필요
        }
        
        if Date().dateToString() == film.createdAt {
            filmNewLabel.isHidden = false
        }
    }
    
    private func createInsideImages(type : FilmFilterType, photo : [Photo]) {
        let repeatCount = photo.count > 3 ? 4 : photo.count
       
        for i in 0..<repeatCount  {
            imageViewArray[i].image = photo[i].image
            imageViewArray[i].tag = i
            
            imageViewArray[i].snp.makeConstraints {
                $0.width.equalTo(type.imageWidth)
                $0.left.equalTo(filmTitleImageView.snp.right).offset(i * (6 + type.imageWidth))
            }
        }
    }
    
    func isEditStarted(value: Bool){
        filmTypeImageView.isHidden = value
        filmDeleteButton.isHidden = !value
    }
    
    func isEditCellSelected(value: Bool) {
        let image = value ? "film_edit_select" : "film_edit_unselect"
        DispatchQueue.main.async { [weak self] in
            self?.filmDeleteButton.setImage(UIImage(named: image), for: .normal)
        }
    }
}
