//
//  AlbumCreateNameViewController.swift
//  90s
//
//  Created by 김진우 on 2021/04/10.
//

import UIKit
import RxSwift
import RxCocoa
import SnapKit
import RxDataSources

class AlbumNameViewController: UIViewController {
    
    private lazy var topBar: UIView = {
        let view = UIView()
        self.view.addSubview(view)
        return view
    }()
    
    private lazy var titleLabel: UILabel = {
        let label = UILabel()
        topBar.addSubview(label)
        label.text = "앨범 만들기(2/3)"
        label.font = .Sub_Head
        return label
    }()
    
    private lazy var backButton: UIButton = {
        let button = UIButton()
        button.setImage(.init(named: "back"), for: .normal)
        topBar.addSubview(button)
        return button
    }()
    
    private lazy var closeButton: UIButton = {
        let button = UIButton()
        button.setImage(.init(named: "close"), for: .normal)
        topBar.addSubview(button)
        return button
    }()
    
    private lazy var descriptionLabel: UILabel = {
        let label = UILabel()
        label.numberOfLines = 2
        label.font = .Sub_Head
        label.text = "이 앨범은 어떤 앨범인가요?\n이름을 정해주세요:)"
        self.view.addSubview(label)
        return label
    }()
    
    private lazy var coverImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.backgroundColor = .green
        self.view.addSubview(imageView)
        return imageView
    }()
    
    private lazy var textField: UITextField = {
        let textField = UITextField()
        textField.font = .Large_Text_Bold
        textField.placeholder = "지은이의 앨범"
        textField.textAlignment = .center
        self.view.addSubview(textField)
        return textField
    }()
    
    private lazy var textFieldLine: UIView = {
        let view = UIView()
        view.backgroundColor = .white
        self.view.addSubview(view)
        return view
    }()
    
    private lazy var button: UIButton = {
        let button = UIButton()
        button.titleLabel?.font = .Btn_Text
        button.setTitle("확인", for: .normal)
        button.isEnabled = false
        button.setTitleColor(.white, for: .normal)
        button.setTitleColor(.white, for: .disabled)
        button.backgroundColor = .Warm_Gray
        button.layer.cornerRadius = 6
        self.view.addSubview(button)
        return button
    }()
    
    private let viewModel: AlbumNameViewModel
    private let disposeBag = DisposeBag()
    
    init(viewModel: AlbumNameViewModel) {
        self.viewModel = viewModel
        
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupUI()
        bindViewModel()
    }
    
    private func setupUI() {
        view.backgroundColor = .black
        
        topBar.snp.makeConstraints {
            $0.top.left.right.equalTo(view.safeAreaLayoutGuide)
            $0.height.equalTo(52 * layoutScale)
        }
        
        titleLabel.snp.makeConstraints {
            $0.height.equalTo(24 * layoutScale)
            $0.center.equalToSuperview()
        }
        
        backButton.snp.makeConstraints {
            $0.width.height.equalTo(34 * layoutScale)
            $0.left.equalToSuperview().offset(9 * layoutScale)
            $0.centerY.equalToSuperview()
        }
        
        closeButton.snp.makeConstraints {
            $0.width.height.equalTo(34 * layoutScale)
            $0.right.equalToSuperview().offset(-9 * layoutScale)
            $0.centerY.equalToSuperview()
        }
        
        descriptionLabel.snp.makeConstraints {
            $0.top.equalTo(topBar.snp.bottom).offset(29 * layoutScale)
            $0.left.equalToSuperview().offset(18 * layoutScale)
        }
        
        coverImageView.snp.makeConstraints {
            $0.width.height.equalTo(44 * layoutScale)
            $0.top.equalTo(topBar.snp.bottom).offset(30 * layoutScale)
            $0.right.equalToSuperview().offset(-17 * layoutScale)
            $0.left.equalTo(descriptionLabel.snp.right).offset(18 * layoutScale)
        }
        
        textField.snp.makeConstraints {
            $0.width.equalTo(118 * layoutScale)
            $0.top.equalTo(descriptionLabel.snp.bottom).offset(24 * layoutScale)
            $0.left.equalToSuperview().offset(18 * layoutScale)
            $0.right.equalToSuperview().offset(-18 * layoutScale)
        }
        
        textFieldLine.snp.makeConstraints {
            $0.height.equalTo(1)
            $0.top.equalTo(textField.snp.bottom).offset(12 * layoutScale)
            $0.left.equalToSuperview().offset(18 * layoutScale)
            $0.right.equalToSuperview().offset(-18 * layoutScale)
        }
        
        button.snp.makeConstraints {
            $0.height.equalTo(56 * layoutScale)
            $0.top.equalTo(textFieldLine.snp.bottom).offset(21 * layoutScale)
            $0.left.equalToSuperview().offset(18 * layoutScale)
            $0.right.equalToSuperview().offset(-18 * layoutScale)
        }
    }
    
    private func bindViewModel() {
        viewModel.output.albumCreate.cover
            .map { $0.image }
            .bind(to: coverImageView.rx.image)
            .disposed(by: disposeBag)
        
        textField.rx.text
            .orEmpty
            .subscribe { text in
                if !(text.element?.isEmpty ?? false) {
                    self.button.backgroundColor = .retroOrange
                    self.button.isEnabled = true
                } else {
                    self.button.backgroundColor = .Warm_Gray
                    self.button.isEnabled = false
                }
            }.disposed(by: disposeBag)
        
        textField.rx.text
            .filter { $0 != nil }
            .map { $0! }
            .bind(to: viewModel.input.name)
            .disposed(by: disposeBag)
        
        backButton.rx.tap
            .subscribe(onNext: { _ in
                self.navigationController?.popViewController(animated: true)
            })
            .disposed(by: disposeBag)
        
        closeButton.rx.tap
            .subscribe(onNext: { _ in
                self.dismiss(animated: true, completion: nil)
            })
            .disposed(by: disposeBag)
        
        button.rx.tap
            .bind(to: viewModel.input.next)
            .disposed(by: disposeBag)
        
        viewModel.output.next
            .subscribe(onNext: { _ in
                self.createAlbum()
            })
            .disposed(by: disposeBag)
    }
    
    private func createAlbum() {
        let vm = viewModel.viewModelForAlbumCreateTemplate()
        let vc = AlbumTemplateViewController(viewModel: vm)
        DispatchQueue.main.async {
            self.navigationController?.pushViewController(vc, animated: true)
        }
    }
}
