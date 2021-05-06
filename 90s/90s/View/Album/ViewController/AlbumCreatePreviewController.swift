//
//  AlbumCreatePreviewController.swift
//  90s
//
//  Created by 김진우 on 2021/04/10.
//

import UIKit
import RxSwift
import RxCocoa
import SnapKit
import RxDataSources

final class AlbumCreatePreviewViewController: UIViewController {
    
    private lazy var descriptionLabel: UILabel = {
        let label = UILabel()
        label.textColor = .white
        self.view.addSubview(label)
        return label
    }()
    
    private lazy var contentsView: UIView = {
        let view = UIView()
        self.view.addSubview(view)
        return view
    }()
    
    private lazy var imageView: UIImageView = {
        let imageView = UIImageView()
        self.contentsView.addSubview(imageView)
        return imageView
    }()
    
    private lazy var line: UIView = {
        let view = UIView()
        self.contentsView.addSubview(view)
        return view
    }()
    
    private lazy var nameLabel: UILabel = {
        let label = UILabel()
        label.textColor = .white
        self.contentsView.addSubview(label)
        return label
    }()
    
    private lazy var coverNameLabel: UILabel = {
        let label = UILabel()
        label.textColor = .white
        self.contentsView.addSubview(label)
        return label
    }()
    
    private lazy var templateNameLabel: UILabel = {
        let label = UILabel()
        label.textColor = .white
        self.contentsView.addSubview(label)
        return label
    }()
    
    private lazy var createDateLabel: UILabel = {
        let label = UILabel()
        label.textColor = .white
        self.contentsView.addSubview(label)
        return label
    }()
    
    private lazy var deco1View: UIView = {
        let view = UIView()
        self.contentsView.addSubview(view)
        return view
    }()
    
    
    private lazy var deco2View: UIView = {
        let view = UIView()
        self.contentsView.addSubview(view)
        return view
    }()
    
    private lazy var button: UIButton = {
        let button = UIButton()
        button.setTitle("확인", for: .normal)
        button.setTitleColor(.white, for: .normal)
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
        self.view.backgroundColor = .black
        
        descriptionLabel.snp.remakeConstraints {
            $0.height.equalTo(46)
            $0.top.equalTo(view.safeAreaLayoutGuide.snp.top).offset(29)
            $0.left.equalToSuperview().offset(18)
        }
        
        contentsView.snp.remakeConstraints {
            $0.width.equalTo(247)
            $0.height.equalTo(378)
            $0.top.equalTo(descriptionLabel.snp.bottom).offset(34)
            $0.centerX.equalToSuperview()
        }
        
        imageView.snp.makeConstraints {
            $0.width.height.equalTo(199)
            $0.top.equalToSuperview().offset(23)
            $0.centerX.equalToSuperview()
        }
        
        nameLabel.snp.makeConstraints {
            $0.height.equalTo(24)
            $0.top.equalTo(imageView.snp.bottom).offset(18)
            $0.centerX.equalToSuperview()
        }
        
        line.snp.makeConstraints {
            $0.top.equalTo(nameLabel.snp.bottom).offset(16)
            $0.height.equalTo(0.5)
            $0.left.equalToSuperview().offset(24)
            $0.right.equalToSuperview().offset(24)
        }
        
        coverNameLabel.snp.makeConstraints {
            $0.height.equalTo(14)
            $0.top.equalTo(line.snp.bottom).offset(16)
            $0.left.equalToSuperview().offset(24)
            $0.right.equalToSuperview().offset(-24)
        }
        
        templateNameLabel.snp.makeConstraints {
            $0.height.equalTo(14)
            $0.top.equalTo(coverNameLabel.snp.bottom).offset(9)
            $0.left.equalToSuperview().offset(24)
            $0.right.equalToSuperview().offset(-24)
        }
        
        createDateLabel.snp.makeConstraints {
            $0.height.equalTo(14)
            $0.top.equalTo(templateNameLabel.snp.bottom).offset(9)
            $0.left.equalToSuperview().offset(24)
            $0.right.equalToSuperview().offset(-24)
        }
        
        button.snp.makeConstraints {
            $0.height.equalTo(57)
            $0.top.equalTo(contentsView.snp.bottom).offset(35)
            $0.left.equalToSuperview().offset(45)
            $0.right.equalToSuperview().offset(-45)
        }
    }
    
    private func bindViewModel() {
        viewModel.selectedCover
            .map { $0.image }
            .asDriver()
            .drive(imageView.rx.image)
            .disposed(by: disposeBag)
        
        viewModel.name
            .asDriver()
            .drive(nameLabel.rx.text)
            .disposed(by: disposeBag)
        
        viewModel.selectedCover
            .map { "커버  \($0.name)" }
            .drive(coverNameLabel.rx.text)
            .disposed(by: disposeBag)
        
        
        viewModel.selectedTemplate
            .map { "템플릿  \($0.name)" }
            .bind(to: templateNameLabel.rx.text)
            .disposed(by: disposeBag)
        
        
        viewModel.createDate
            .map { "생성일  \($0.toString)" }
            .drive(coverNameLabel.rx.text)
            .disposed(by: disposeBag)
        
        button.rx.tap
            .subscribe(onNext: { _ in
                AlbumProvider.addAndUpdate(Album(id: "", name: self.viewModel.nameRelay.value, date: self.viewModel.dateRelay.value.toString, maxCount: 0, cover: self.viewModel.selectedCoverRelay.value))
                DispatchQueue.main.async {
                    self.dismiss(animated: true)
                }
            })
            .disposed(by: disposeBag)
    }
}

extension Date {
    var toString: String {
        let formatter = DateFormatter()
        formatter.dateFormat = "yyyy-MM-dd"
        return formatter.string(from: self)
    }
}
