//
//  PopupViewController.swift
//  90s
//
//  Created by 김진우 on 2021/11/25.
//

import UIKit

import RxSwift
import RxCocoa
import SnapKit

final class PopupViewController: UIViewController {
    
    // MARK: - UI Component
    private lazy var contentView: UIView = {
        let view = UIView()
        view.backgroundColor = .Cool_Gray
        self.view.addSubview(view)
        return view
    }()
    
    private lazy var imageView: UIImageView = {
        let imageView = UIImageView()
        contentView.addSubview(imageView)
        return imageView
    }()
    
    private lazy var label: UILabel = {
        let label = UILabel()
        label.numberOfLines = 0
        label.textAlignment = .center
        label.font = .popupTitle
        label.textColor = .white
        contentView.addSubview(label)
        return label
    }()
    
    private lazy var cancelButton: UIButton = {
        let button = UIButton()
        button.backgroundColor = .Cool_Lightgray
        button.titleLabel?.font = .buttonText
        button.setTitleColor(.lightGrey, for: .normal)
        button.layer.cornerRadius = 8 * layoutScale
        contentView.addSubview(button)
        return button
    }()
    
    private lazy var okButton: UIButton = {
        let button = UIButton()
        button.backgroundColor = .retroOrange
        button.titleLabel?.font = .buttonText
        button.setTitleColor(.white, for: .normal)
        button.layer.cornerRadius = 8 * layoutScale
        contentView.addSubview(button)
        return button
    }()
    
    // MARK: - Property
    private let disposeBag = DisposeBag()
    private let viewModel: PopupViewModel
    
    // MARK: - Init
    init(viewModel: PopupViewModel) {
        self.viewModel = viewModel
        
        super.init(nibName: nil, bundle: nil)
        
        setupUI()
        bindState()
        bindAction()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - Life Cycle
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        
        let path = UIBezierPath(roundedRect:contentView.bounds, byRoundingCorners:[.topRight, .topLeft], cornerRadii: CGSize(width: 12 * layoutScale, height:  12 * layoutScale))
        let maskLayer = CAShapeLayer()
        maskLayer.path = path.cgPath
        contentView.layer.mask = maskLayer
    }
    
    // MARK: - Setup Method
    private func setupUI() {
        view.backgroundColor = .actionSheet
        
        contentView.snp.makeConstraints {
            $0.height.equalTo(contentView.snp.width).multipliedBy(0.722666)
            $0.leading.trailing.equalToSuperview()
            $0.bottom.equalTo(view.safeAreaLayoutGuide.snp.bottom)
        }
        
        imageView.snp.makeConstraints {
            $0.height.width.equalTo(59 * layoutScale)
            $0.centerX.equalToSuperview()
            $0.top.equalToSuperview().offset(24 * layoutScale)
        }
        
        label.snp.makeConstraints {
            $0.height.equalTo(46 * layoutScale)
            $0.top.equalTo(imageView.snp.bottom).offset(13 * layoutScale)
            $0.centerX.equalToSuperview()
        }
        
        cancelButton.snp.makeConstraints {
            $0.width.equalTo(164 * layoutScale)
            $0.height.equalTo(57 * layoutScale)
            $0.top.equalTo(label.snp.bottom).offset(40 * layoutScale)
            $0.leading.equalToSuperview().offset(18)
        }
        
        okButton.snp.makeConstraints {
            $0.width.equalTo(164 * layoutScale)
            $0.height.equalTo(57 * layoutScale)
            $0.top.equalTo(label.snp.bottom).offset(40 * layoutScale)
            $0.trailing.equalToSuperview().offset(-18)
        }
    }
    
    private func bindAction() {
        cancelButton.rx.tap
            .bind(to: viewModel.input.reject)
            .disposed(by: disposeBag)
        
        okButton.rx.tap
            .bind(to: viewModel.input.conform)
            .disposed(by: disposeBag)
    }
    
    private func bindState() {
        viewModel.output.iconImage
            .bind(to: imageView.rx.image)
            .disposed(by: disposeBag)
        
        viewModel.output.title
            .bind(to: label.rx.text)
            .disposed(by: disposeBag)
        
        viewModel.output.rejectTitle
            .bind(to: cancelButton.rx.title())
            .disposed(by: disposeBag)
        
        viewModel.output.conformTitle
            .bind(to: okButton.rx.title())
            .disposed(by: disposeBag)
    }
}
