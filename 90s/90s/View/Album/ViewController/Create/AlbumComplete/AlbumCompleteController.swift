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

final class AlbumCompleteViewController: UIViewController {
    
    private lazy var topBar: UIView = {
        let view = UIView()
        self.view.addSubview(view)
        return view
    }()
    
    private lazy var backButton: UIButton = {
        let button = UIButton()
        button.setImage(.init(named: "navigationBar_back"), for: .normal)
        topBar.addSubview(button)
        return button
    }()
    
    private lazy var closeButton: UIButton = {
        let button = UIButton()
        button.setImage(.init(named: "navigationBar_close"), for: .normal)
        topBar.addSubview(button)
        return button
    }()
    
    private lazy var descriptionLabel: UILabel = {
        let label = UILabel()
        label.font = .subHead
        label.text = "앨범이\n완성되었습니다!"
        label.numberOfLines = 2
        label.textColor = .white
        self.view.addSubview(label)
        return label
    }()
    
    private lazy var contentsView: UIView = {
        let view = UIView()
        view.backgroundColor = .brown
        view.layer.cornerRadius = 8 * layoutScale
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
        view.backgroundColor = .white
        self.contentsView.addSubview(view)
        return view
    }()
    
    private lazy var nameLabel: UILabel = {
        let label = UILabel()
        label.font = .popupTitle
        label.textColor = .white
        self.contentsView.addSubview(label)
        return label
    }()
    
    private lazy var coverNameLabel: UILabel = {
        let label = UILabel()
        label.font = .smallTextBold
        label.textColor = .white
        self.contentsView.addSubview(label)
        return label
    }()
    
    private lazy var templateNameLabel: UILabel = {
        let label = UILabel()
        label.font = .smallTextBold
        label.textColor = .white
        self.contentsView.addSubview(label)
        return label
    }()
    
    private lazy var createDateLabel: UILabel = {
        let label = UILabel()
        label.font = .smallTextBold
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
        button.backgroundColor = .retroOrange
        button.titleLabel?.font = .buttonText
        button.layer.cornerRadius = 6
        button.setTitle("확인", for: .normal)
        button.setTitleColor(.white, for: .normal)
        self.view.addSubview(button)
        return button
    }()
    
    private let viewModel: AlbumCompleteViewModel
    private let disposeBag = DisposeBag()
    
    init(viewModel: AlbumCompleteViewModel) {
        self.viewModel = viewModel
        
        super.init(nibName: nil, bundle: nil)
        
        setupUI()
        bindState()
        bindAction()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setupUI() {
        self.view.backgroundColor = .black
        
        topBar.snp.makeConstraints {
            $0.top.left.right.equalTo(view.safeAreaLayoutGuide)
            $0.height.equalTo(52 * layoutScale)
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
        
        descriptionLabel.snp.remakeConstraints {
            $0.height.equalTo(46 * layoutScale)
            $0.top.equalTo(topBar.snp.bottom).offset(29 * layoutScale)
            $0.left.equalToSuperview().offset(18 * layoutScale)
        }
        
        contentsView.snp.remakeConstraints {
            $0.width.equalTo(247 * layoutScale)
            $0.height.equalTo(378 * layoutScale)
            $0.top.equalTo(descriptionLabel.snp.bottom).offset(34 * layoutScale)
            $0.centerX.equalToSuperview()
        }
        
        imageView.snp.makeConstraints {
            $0.width.height.equalTo(199 * layoutScale)
            $0.top.equalToSuperview().offset(23 * layoutScale)
            $0.centerX.equalToSuperview()
        }
        
        nameLabel.snp.makeConstraints {
            $0.height.equalTo(24 * layoutScale)
            $0.top.equalTo(imageView.snp.bottom).offset(18 * layoutScale)
            $0.centerX.equalToSuperview()
        }
        
        line.snp.makeConstraints {
            $0.top.equalTo(nameLabel.snp.bottom).offset(16 * layoutScale)
            $0.height.equalTo(0.5 * layoutScale)
            $0.left.equalToSuperview().offset(24 * layoutScale)
            $0.right.equalToSuperview().offset(-24 * layoutScale)
        }
        
        coverNameLabel.snp.makeConstraints {
            $0.height.equalTo(14 * layoutScale)
            $0.top.equalTo(line.snp.bottom).offset(16 * layoutScale)
            $0.left.equalToSuperview().offset(24 * layoutScale)
            $0.right.equalToSuperview().offset(-24 * layoutScale)
        }
        
        templateNameLabel.snp.makeConstraints {
            $0.height.equalTo(14 * layoutScale)
            $0.top.equalTo(coverNameLabel.snp.bottom).offset(9 * layoutScale)
            $0.left.equalToSuperview().offset(24 * layoutScale)
            $0.right.equalToSuperview().offset(-24 * layoutScale)
        }
        
        createDateLabel.snp.makeConstraints {
            $0.height.equalTo(14 * layoutScale)
            $0.top.equalTo(templateNameLabel.snp.bottom).offset(9 * layoutScale)
            $0.left.equalToSuperview().offset(24 * layoutScale)
            $0.right.equalToSuperview().offset(-24 * layoutScale)
        }
        
        button.snp.makeConstraints {
            $0.height.equalTo(57 * layoutScale)
            $0.top.equalTo(contentsView.snp.bottom).offset(35 * layoutScale)
            $0.left.equalToSuperview().offset(45 * layoutScale)
            $0.right.equalToSuperview().offset(-45 * layoutScale)
        }
    }
    
    private func bindState() {
        viewModel.output.albumCreate.cover
            .map { $0.image }
            .bind(to: imageView.rx.image)
            .disposed(by: disposeBag)
        
        viewModel.output.albumCreate.name
            .bind(to: nameLabel.rx.text)
            .disposed(by: disposeBag)
        
        viewModel.output.albumCreate.cover
            .map { "커버     \($0.name)" }
            .bind(to: coverNameLabel.rx.text)
            .disposed(by: disposeBag)
        
        
        viewModel.output.albumCreate.template
            .map { "템플릿  \($0.name)" }
            .bind(to: templateNameLabel.rx.text)
            .disposed(by: disposeBag)
        
        
        viewModel.output.albumCreate.date
            .map { "생성일  \($0.toString)" }
            .bind(to: createDateLabel.rx.text)
            .disposed(by: disposeBag)
        
        viewModel.output.back
            .bind { _ in
                self.back()
            }
            .disposed(by: disposeBag)
        
        viewModel.output.close
            .bind { _ in
                self.dismiss()
            }
            .disposed(by: disposeBag)
        
        viewModel.output.complete
            .bind { _ in
                self.dismiss()
            }
            .disposed(by: disposeBag)
    }
    
    private func bindAction() {
        backButton.rx.tap
            .bind(to: viewModel.input.back)
            .disposed(by: disposeBag)
        
        closeButton.rx.tap
            .bind(to: viewModel.input.close)
            .disposed(by: disposeBag)
        
        button.rx.tap
            .bind(to: viewModel.input.complete)
            .disposed(by: disposeBag)
    }
    
    // MARK: - Method
    private func back() {
        DispatchQueue.main.async {
            self.navigationController?.popViewController(animated: true)
        }
    }
    private func dismiss() {
        DispatchQueue.main.async {
            self.dismiss(animated: true)
        }
    }
}

extension Date {
    var toString: String {
        let formatter = DateFormatter()
        formatter.dateFormat = "yyyy-MM-dd"
        return formatter.string(from: self)
    }
}
