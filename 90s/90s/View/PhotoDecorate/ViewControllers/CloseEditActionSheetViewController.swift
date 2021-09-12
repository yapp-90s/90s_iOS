//
//  CloseActionSheetViewController.swift
//  90s
//
//  Created by kakao on 2021/09/11.
//

import UIKit
import SnapKit

class CloseEditActionSheetViewController: ActionSheetViewController {
    
    // MARK: - Views
    
    private var descriptionLabel: UILabel = {
        let label = UILabel()
        label.text = "편집한 사진을 저장하지 않고\n종료하시겠습니까?"
        label.textColor = .white
        label.textAlignment = .center
        label.numberOfLines = 0
        return label
    }()
    
    private var buttonsBackgroundStackView: UIStackView = {
        let stackView = UIStackView()
        stackView.axis = .horizontal
        stackView.distribution = .fillEqually
        stackView.spacing = 11
        return stackView
    }()
    
    private lazy var cancelButton: UIButton = {
        let button = UIButton()
        button.setTitle("취소하기", for: .normal)
        button.backgroundColor = .Cool_Lightgray
        button.layer.cornerRadius = 6
        button.addTarget(self, action: #selector(self.tappedCancelButton), for: .touchUpInside)
        return button
    }()
    
    private lazy var closeButton: UIButton = {
        let button = UIButton()
        button.setTitle("종료하기", for: .normal)
        button.backgroundColor = .retroOrange
        button.layer.cornerRadius = 6
        button.addTarget(self, action: #selector(self.tappedCloseButton), for: .touchUpInside)
        return button
    }()
    
    // MARK: - Properties
    
    let viewModel: CloseEditActionSheetViewModel
    
    // MARK: - View Life Cycle
    
    init(viewModel: CloseEditActionSheetViewModel) {
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        self.viewModel = .init(dependency: .init())
        super.init(coder: coder)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.setupViews()
        self.bind()
    }
    
    private func setupViews() {
        self.actionSheetHeight = 270
        
        self.actionSheetContentView.addSubview(self.descriptionLabel)
        self.actionSheetContentView.addSubview(self.buttonsBackgroundStackView)
        self.buttonsBackgroundStackView.addArrangedSubview(cancelButton)
        self.buttonsBackgroundStackView.addArrangedSubview(closeButton)
        
        self.buttonsBackgroundStackView.snp.makeConstraints { maker in
            maker.leading.trailing.equalToSuperview().inset(18)
            maker.bottom.equalToSuperview().inset(49)
            maker.height.equalTo(57)
        }
        
        self.descriptionLabel.snp.makeConstraints { maker in
            maker.top.leading.trailing.equalToSuperview()
            maker.bottom.equalTo(self.buttonsBackgroundStackView.snp.top)
            maker.centerX.equalToSuperview()
        }
    }
    
    private func bind() {
        self.viewModel.output.cancel
            .subscribe(onNext: { [weak self] _ in
                self?.dismiss(animated: true, completion: nil)
            })
            .disposed(by: disposeBag)
        
        self.viewModel.output.close
            .subscribe(onNext: { [weak self] _ in
                // TODO: pop 시키는건지 아예 편집쪽 종료하는건지 체크
                let navigationViewController = self?.presentingViewController as? UINavigationController
                self?.dismiss(animated: true) {
                    navigationViewController?.popViewController(animated: true)
                }
            })
            .disposed(by: disposeBag)
    }
    
    @objc
    private func tappedCancelButton() {
        self.viewModel.input.tappedCancelButton.onNext(())
    }
    
    @objc
    private func tappedCloseButton() {
        self.viewModel.input.tappedCloseButton.onNext(())
    }
}
