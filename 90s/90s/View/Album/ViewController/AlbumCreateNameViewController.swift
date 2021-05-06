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

class AlbumCreateNameViewController: UIViewController {
    
    private lazy var titleLabel: UILabel = {
        let label = UILabel()
        label.numberOfLines = 2
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
        button.setTitle("확인", for: .normal)
        button.isEnabled = false
        button.setTitleColor(.white, for: .normal)
        button.setTitleColor(.white, for: .disabled)
        button.backgroundColor = .Warm_Gray
        button.layer.cornerRadius = 6
        self.view.addSubview(button)
        return button
    }()
    
    private let viewModel: AlbumCreateViewModel
    private let disposeBag = DisposeBag()
    
    init(viewModel: AlbumCreateViewModel) {
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
        
        titleLabel.snp.makeConstraints {
            $0.top.equalTo(view.safeAreaLayoutGuide.snp.top).offset(29)
            $0.left.equalToSuperview().offset(18)
        }
        
        coverImageView.snp.makeConstraints {
            $0.width.height.equalTo(44)
            $0.top.equalTo(view.safeAreaLayoutGuide.snp.top).offset(30)
            $0.right.equalToSuperview().offset(-17)
            $0.left.equalTo(titleLabel.snp.right).offset(18)
        }
        
        textField.snp.makeConstraints {
            $0.width.equalTo(118)
            $0.top.equalTo(titleLabel.snp.bottom).offset(24)
            $0.left.equalToSuperview().offset(18)
            $0.right.equalToSuperview().offset(-18)
        }
        
        textFieldLine.snp.makeConstraints {
            $0.height.equalTo(1)
            $0.top.equalTo(textField.snp.bottom).offset(12)
            $0.left.equalToSuperview().offset(18)
            $0.right.equalToSuperview().offset(-18)
        }
        
        button.snp.makeConstraints {
            $0.height.equalTo(56)
            $0.top.equalTo(textFieldLine.snp.bottom).offset(21)
            $0.left.equalToSuperview().offset(18)
            $0.right.equalToSuperview().offset(-18)
        }
    }
    
    private func bindViewModel() {
        viewModel.selectedCover
            .map { $0.image }
            .asDriver()
            .drive(coverImageView.rx.image)
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
        
        
        viewModel.next
            .subscribe { _ in
                self.createAlbum()
            }.disposed(by: disposeBag)
        
        
        button.rx.tap
            .bind(to: viewModel.next)
            .disposed(by: disposeBag)
    }
    
    private func createAlbum() {
        let vc = AlbumCreateTemplateViewController(viewModel: viewModel)
        DispatchQueue.main.async {
            self.navigationController?.pushViewController(vc, animated: false)
        }
    }
}
