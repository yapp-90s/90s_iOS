//
//  ContentEmptyView.swift
//  90s
//
//  Created by 김진우 on 2022/01/02.
//

import UIKit

import RxSwift

final class ContentEmptyView: UIView {
    
    // MARK: - UI Component
    private lazy var contentView: UIView = {
        let view = UIView()
        addSubview(view)
        return view
    }()
    
    private lazy var imageView: UIImageView = {
        let imageView = UIImageView()
        contentView.addSubview(imageView)
        return imageView
    }()
    
    private lazy var titleLabel: UILabel = {
        let label = UILabel()
        label.font = .subHead
        label.textColor = .white
        label.textAlignment = .center
        label.numberOfLines = 0
        contentView.addSubview(label)
        return label
    }()
    
    private lazy var createButton: UIButton = {
        let button = UIButton()
        button.layer.cornerRadius = 6 * layoutScale
        button.backgroundColor = .Cool_Gray
        button.titleLabel?.font = .buttonText
        button.titleLabel?.textColor = .white
        contentView.addSubview(button)
        return button
    }()
    
    // MARK: - Property
    private let viewModel: ContentEmptyViewModel
    private let disposeBag = DisposeBag()
    
    // MARK: - Init
    init(viewModel: ContentEmptyViewModel) {
        self.viewModel = viewModel
        
        super.init(frame: .zero)
        commonInit()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func commonInit() {
        setupUI()
        bindState()
        bindAction()
    }
    
    private func setupUI() {
        backgroundColor = .black
        
        contentView.snp.makeConstraints {
            $0.leading.trailing.equalToSuperview()
            $0.centerY.equalToSuperview()
        }
        
        imageView.snp.makeConstraints {
            $0.height.equalTo(imageView.snp.width).multipliedBy(0.912)
            $0.top.leading.trailing.equalToSuperview()
        }
        
        titleLabel.snp.makeConstraints {
            $0.height.equalTo(46 * layoutScale)
            $0.top.equalTo(imageView.snp.bottom).offset(17 * layoutScale)
            $0.centerX.equalToSuperview()
        }
        
        createButton.snp.makeConstraints {
            $0.width.equalTo(123 * layoutScale)
            $0.height.equalTo(48 * layoutScale)
            $0.top.equalTo(titleLabel.snp.bottom).offset(32 * layoutScale)
            $0.bottom.equalToSuperview().offset(-16 * layoutScale)
            $0.centerX.equalToSuperview()
        }
    }
    
    private func bindAction() {
        createButton.rx.tap
            .bind(to: viewModel.input.create)
            .disposed(by: disposeBag)
    }
    
    private func bindState() {
        viewModel.output.create
            .bind { _ in
                print("Create")
            }
            .disposed(by: disposeBag)
        
        viewModel.output.title
            .bind(to: titleLabel.rx.text)
            .disposed(by: disposeBag)
        
        viewModel.output.buttonTitle
            .bind(to: createButton.rx.title())
            .disposed(by: disposeBag)
        
        viewModel.output.image
            .bind(to: imageView.rx.image)
            .disposed(by: disposeBag)
    }
}
