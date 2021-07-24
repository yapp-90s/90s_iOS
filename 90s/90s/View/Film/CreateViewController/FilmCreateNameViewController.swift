//
//  FilmCreateNameViewController.swift
//  90s
//
//  Created by 성다연 on 2021/04/22.
//

import UIKit
import SnapKit

final class FilmCreateNameViewController: BaseViewController {
    private let infoLabel : UILabel = {
        let label = UILabel.createSpacingLabel(text: "어디에 사용되는 필름인가요?\n이름을 정해주세요 :)")
        return label
    }()
    
    private let imageView : UIImageView = {
        let iv = UIImageView(frame: .zero)
        iv.clipsToBounds = true
        iv.layer.cornerRadius = 5
        iv.contentMode = .scaleToFill
        return iv
    }()
    
    private var textField : UITextField = {
        let tf = UITextField(frame: .zero)
        tf.font = .boldSystemFont(ofSize: 20)
        tf.textAlignment = .center
        tf.placeholder = "강릉 여행"
        tf.clearButtonMode = .whileEditing
        return tf
    }()
    
    private let textFieldLine : UIView = {
        let view = UIView(frame: .zero)
        view.backgroundColor = .white
        return view
    }()
    
    private let completeButton : UIButton = {
        let button = UIButton(frame: .zero)
        button.backgroundColor = .warmGray
        button.clipsToBounds = true
        button.layer.cornerRadius = 6
        button.setTitle("확인", for: .normal)
        button.tintColor = .white
        button.titleLabel?.font = .boldSystemFont(ofSize: 16)
        button.isEnabled = false
        return button
    }()

    var film: Film! {
        didSet {
            imageView.image = UIImage(named: film.filmType.name.image)
        }
    }
    
    var delegate : FilmCreateViewControllerDelegate?
    private var filmName : String = ""
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setUpSubViews()
        setUpTextField()
        setUpCompleteButton()
    }
    
    private func setUpSubViews(){
        navigationItem.title = "필름 만들기"
        setBarButtonItem(type: .imgClose, position: .right, action: #selector(handleNavigationRightButton))
        
        view.backgroundColor = .black
        
        view.addSubview(infoLabel)
        view.addSubview(imageView)
        view.addSubview(textField)
        view.addSubview(textFieldLine)
        view.addSubview(completeButton)
        
        let safe = view.safeAreaLayoutGuide
        
        infoLabel.snp.makeConstraints {
            $0.left.equalTo(18)
            $0.top.equalTo(safe).offset(28)
        }
        
        imageView.snp.makeConstraints {
            $0.height.equalTo(44)
            $0.width.equalTo(32)
            $0.top.equalTo(safe).offset(30)
            $0.right.equalTo(-18)
        }
        
        textField.snp.makeConstraints {
            $0.top.equalTo(infoLabel.snp.bottom).offset(53)
            $0.left.equalTo(18)
            $0.right.equalTo(-18)
            $0.height.equalTo(30)
        }
        
        textFieldLine.snp.makeConstraints {
            $0.height.equalTo(1)
            $0.left.equalTo(18)
            $0.right.equalTo(-18)
            $0.top.equalTo(textField.snp.bottom).offset(8)
        }
        
        completeButton.snp.makeConstraints {
            $0.height.equalTo(57)
            $0.left.equalTo(18)
            $0.right.equalTo(-18)
            $0.top.equalTo(textFieldLine.snp.bottom).offset(35)
        }
    }
    
    private func setUpTextField(){
        textField.rx.controlEvent([.editingChanged])
            .asObservable()
            .subscribe(onNext: { _ in
               
                guard let text = self.textField.text else {return}
               
                if !text.trimmingCharacters(in: .whitespaces).isEmpty {
                    self.filmName = text
                    self.completeButton.backgroundColor = .retroOrange
                    self.completeButton.isEnabled = true
                } else {
                    self.completeButton.backgroundColor = .warmGray
                    self.completeButton.isEnabled = false
                }
            }).disposed(by: disposeBag)
    }
    
    private func setUpCompleteButton(){
        completeButton.rx.tap.bind {
            let nextVC = FilmCreateCompleteViewController()
            self.film.name = self.filmName
            nextVC.film = self.film
            nextVC.delegate = self.delegate
            nextVC.bindViewModel(film: self.film)
            self.navigationController?.pushViewController(nextVC, animated: true)
        }.disposed(by: disposeBag)
    }

    @objc private func handleNavigationRightButton(){
        delegate?.popupToFilmCreateVC()
    }
}
