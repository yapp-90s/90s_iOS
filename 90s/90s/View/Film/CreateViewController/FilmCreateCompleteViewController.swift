//
//  FilmCreateCompleteViewController.swift
//  90s
//
//  Created by 성다연 on 2021/04/22.
//

import UIKit
import SnapKit
import QBImagePickerController

class FilmCreateCompleteViewController: BaseViewController {
    private let infoLabel : UILabel = {
        let label = UILabel.createSpacingLabel(text: "필름이\n완성되었습니다!")
        return label
    }()

    private var filmView: UIView = {
        let view = UIView(frame: .zero)
        return view
    }()
    
    private let filmImageView : UIImageView = {
        let iv = UIImageView(frame: .zero)
        iv.clipsToBounds = true
        iv.layer.cornerRadius = 8
        iv.contentMode = .scaleAspectFit
        return iv
    }()
    
    private var filmNameLabel : UILabel = {
        let label = LabelType.bold_18.create()
        return label
    }()
    
    private var filmSeperateView : UIView = {
        let view = UIView(frame: .zero)
        view.backgroundColor = .white
        return view
    }()
    
    private var filmTypeLabel : UILabel = {
        let label = UILabel(frame: .zero)
        return label
    }()
    
    private var filmPrintLabel : UILabel = {
        let label = UILabel(frame: .zero)
        return label
    }()
    
    private var filmCountLabel : UILabel = {
        let label = UILabel(frame: .zero)
        return label
    }()
    
    private var filmDateLabel : UILabel = {
        let label = UILabel(frame: .zero)
        return label
    }()
    
    private var completeButton : UIButton = {
        let button = UIButton(frame: .zero)
        button.backgroundColor = .retroOrange
        button.clipsToBounds = true
        button.layer.cornerRadius = 8
        button.setTitle("확인", for: .normal)
        button.tintColor = .white
        button.titleLabel?.font = .boldSystemFont(ofSize: 16)
        return button
    }()
    
    private var popUpView : UIView = {
        let view = UIView(frame: .zero)
        view.clipsToBounds = true
        view.layer.cornerRadius = 15
        return view
    }()
    
    private let popUpImageView : UIImageView = {
        let iv = UIImageView(frame: .zero)
        iv.image = UIImage(named: "film_create_addphotos")
        iv.contentMode = .scaleAspectFit
        return iv
    }()
    
    private let popUpInfoLabel : UILabel = {
        let label = UILabel.createSpacingLabel(text: "새로 만든 필름에\n사진을 바로 추가하시겠어요?")
        label.textAlignment = .center
        return label
    }()
    
    private let popUpCancleButton : UIButton = {
        let button = UIButton(frame: .zero)
        button.backgroundColor = .warmLightgray
        button.clipsToBounds = true
        button.layer.cornerRadius = 8
        button.setTitle("나중에", for: .normal)
        button.tintColor = .white
        button.titleLabel?.font = .boldSystemFont(ofSize: 14)
        return button

    }()
    
    private let popUpAddButton : UIButton = {
        let button = UIButton(frame: .zero)
        button.backgroundColor = .retroOrange
        button.clipsToBounds = true
        button.layer.cornerRadius = 8
        button.setTitle("사진 추가하기", for: .normal)
        button.tintColor = .white
        button.titleLabel?.font = .boldSystemFont(ofSize: 14)
        return button
    }()
    
    private let imagePicker : QBImagePickerController = {
        let ip = QBImagePickerController()
        ip.allowsMultipleSelection = true
        ip.showsNumberOfSelectedAssets = true
        return ip
    }()
    
    var film : Film!
    var delegate : FilmCreateViewControllerDelegate?
    private var isPopUpAppeared = false
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setUpSubViews()
        setUpPopUpSubViews()
        handleCompleteButton()
    }

    private func setUpSubViews(){
        view.backgroundColor = .black
        view.addSubview(infoLabel)
        view.addSubview(filmView)
        view.addSubview(completeButton)
        
        imagePicker.delegate = self
        setBarButtonItem(type: .imgClose, position: .right, action: #selector(handleNavigationRightButton))
        
        filmView.addSubview(filmImageView)
        filmView.addSubview(filmNameLabel)
        filmView.addSubview(filmSeperateView)
        filmView.addSubview(filmTypeLabel)
        filmView.addSubview(filmPrintLabel)
        filmView.addSubview(filmCountLabel)
        filmView.addSubview(filmDateLabel)
        
        let safe = view.safeAreaLayoutGuide
        
        infoLabel.snp.makeConstraints {
            $0.left.equalTo(18)
            $0.top.equalTo(safe).offset(29)
        }
        
        filmView.snp.makeConstraints {
            $0.left.equalTo(64)
            $0.right.equalTo(-64)
            $0.top.equalTo(infoLabel.snp.bottom).offset(34)
            $0.height.equalTo(378)
        }
        
        completeButton.snp.makeConstraints {
            $0.left.equalTo(45)
            $0.right.equalTo(-45)
            $0.height.equalTo(57)
            $0.top.equalTo(filmView.snp.bottom).offset(30)
        }
        
        filmImageView.snp.makeConstraints {
            $0.top.equalTo(filmView.snp.top).offset(25)
            $0.left.equalTo(filmView.snp.left).offset(61)
            $0.right.equalTo(filmView.snp.right).offset(-61)
            $0.height.equalTo(173)
        }
        
        filmNameLabel.snp.makeConstraints {
            $0.top.equalTo(filmImageView.snp.bottom).offset(17)
            $0.centerX.equalTo(filmImageView.snp.centerX)
        }
        
        filmSeperateView.snp.makeConstraints {
            $0.top.equalTo(filmNameLabel.snp.bottom).offset(16)
            $0.left.equalTo(filmView.snp.left).offset(24)
            $0.right.equalTo(filmView.snp.right).offset(-24)
            $0.height.equalTo(1)
        }
        
        filmTypeLabel.snp.makeConstraints {
            $0.left.equalTo(filmView.snp.left).offset(24)
            $0.top.equalTo(filmSeperateView.snp.bottom).offset(17)
        }
        
        filmPrintLabel.snp.makeConstraints {
            $0.left.equalTo(filmView.snp.left).offset(24)
            $0.top.equalTo(filmTypeLabel.snp.bottom).offset(9)
        }
        
        filmCountLabel.snp.makeConstraints {
            $0.left.equalTo(filmView.snp.left).offset(24)
            $0.top.equalTo(filmPrintLabel.snp.bottom).offset(9)
        }
        
        filmDateLabel.snp.makeConstraints {
            $0.left.equalTo(filmView.snp.left).offset(24)
            $0.top.equalTo(filmCountLabel.snp.bottom).offset(9)
        }
    }
    
    private func setUpPopUpSubViews(){
        view.addSubview(popUpView)
        popUpView.backgroundColor = .warmGray
        popUpView.addSubview(popUpImageView)
        popUpView.addSubview(popUpInfoLabel)
        popUpView.addSubview(popUpCancleButton)
        popUpView.addSubview(popUpAddButton)
        
        popUpView.snp.makeConstraints {
            $0.left.right.equalTo(0)
            $0.height.equalTo(300)
            $0.top.equalTo(view.snp.bottom)
        }
        
        popUpImageView.snp.makeConstraints {
            $0.width.height.equalTo(60)
            $0.top.equalTo(popUpView.snp.top).offset(24)
            $0.centerX.equalTo(popUpView.snp.centerX)
        }
        
        popUpInfoLabel.snp.makeConstraints {
            $0.top.equalTo(popUpImageView.snp.bottom).offset(13)
            $0.centerX.equalTo(popUpView.snp.centerX)
        }
        
        popUpCancleButton.snp.makeConstraints {
            $0.width.equalTo((view.bounds.size.width - 46) / 2)
            $0.left.equalTo(popUpView.snp.left).offset(18)
            $0.height.equalTo(57)
            $0.top.equalTo(popUpInfoLabel.snp.bottom).offset(40)
        }
        
        popUpAddButton.snp.makeConstraints {
            $0.width.equalTo((view.bounds.size.width - 46) / 2)
            $0.right.equalTo(popUpView.snp.right).offset(-18)
            $0.height.equalTo(57)
            $0.top.equalTo(popUpInfoLabel.snp.bottom).offset(40)
        }
    }
    
    private func handleCompleteButton(){
        let tap = UITapGestureRecognizer(target: self, action: #selector(handleTapGesture(sender:)))
        view.addGestureRecognizer(tap)
        
        completeButton.rx.tap.bind {
            self.updatePopUpView()
        }.disposed(by: disposeBag)
        
        popUpCancleButton.rx.tap.bind {
            self.updatePopUpView()
        }.disposed(by: disposeBag)
        
        popUpAddButton.rx.tap.bind {
            self.present(self.imagePicker, animated: true, completion: nil)
            self.updatePopUpView()
        }.disposed(by: disposeBag)
    }
    
    private func updatePopUpView(){
        isPopUpAppeared = !isPopUpAppeared
        
        if isPopUpAppeared == true {
            popUpView.snp.remakeConstraints {
                $0.left.right.equalTo(0)
                $0.height.equalTo(300)
                $0.top.equalTo(view.snp.bottom).offset(-300)
            }
        } else {
            popUpView.snp.remakeConstraints {
                $0.left.right.equalTo(0)
                $0.height.equalTo(300)
                $0.top.equalTo(view.snp.bottom)
            }
        }
        
        UIView.animate(withDuration: 0.3, animations: {
            self.view.layoutIfNeeded()
        })
    }
    
    func bindViewModel(film : Film) {
        DispatchQueue.main.async { [weak self] in
            self?.filmImageView.image = UIImage(named: film.filterType.image())
        }
        
        filmNameLabel.text = film.name
        filmTypeLabel = UILabel.createNormalBoldLabel(normal: "종류", bold: " " + film.filterType.rawValue)
        filmPrintLabel = UILabel.createNormalBoldLabel(normal: "인화 시간", bold: "\(film.filterType.printDay())시간")
        filmCountLabel = UILabel.createNormalBoldLabel(normal: "사진 개수", bold: "\(film.count)장")
        filmDateLabel = UILabel.createNormalBoldLabel(normal: "생성일", bold: film.createDate)
    }
    
    @objc private func handleNavigationRightButton(){
        delegate?.popupToFilmCreateVC()
    }
    
    @objc private func handleTapGesture(sender: UITapGestureRecognizer){
        updatePopUpView()
    }
}

extension FilmCreateCompleteViewController : QBImagePickerControllerDelegate {
    func qb_imagePickerControllerDidCancel(_ imagePickerController: QBImagePickerController!) {
        dismiss(animated: true)
    }
    
    func qb_imagePickerController(_ imagePickerController: QBImagePickerController!, didFinishPickingAssets assets: [Any]!) {
        dismiss(animated: true)
    }
}
