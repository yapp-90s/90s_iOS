//
//  CloseActionSheetViewController.swift
//  90s
//
//  Created by kakao on 2021/09/11.
//

import UIKit
import SnapKit

class CloseEditActionSheetViewController: BaseViewController {
    
    // MARK: - Views
    
    private var actionSheetBackgroundView: UIView = {
        let view = UIView()
        view.isUserInteractionEnabled = true
        view.translatesAutoresizingMaskIntoConstraints = false
        view.backgroundColor = .Cool_Gray
        return view
    }()
    
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
    
    private var cancelButton: UIButton = {
        let button = UIButton()
        button.setTitle("취소하기", for: .normal)
        button.backgroundColor = .Cool_Lightgray
        button.layer.cornerRadius = 6
        return button
    }()
    
    private var closeButton: UIButton = {
        let button = UIButton()
        button.setTitle("종료하기", for: .normal)
        button.backgroundColor = .retroOrange
        button.layer.cornerRadius = 6
        return button
    }()
    
    // MARK: - Properties
    
    let viewModel: CloseEditActionSheetViewModel
    fileprivate var isPresenting = false
    fileprivate var actionSheetTopConstraint: Constraint?
    fileprivate var actionSheetBottomConstraint: Constraint?
    
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
        self.transitioningDelegate = self
        self.setupViews()
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        if let touch = touches.first, touch.view == self.view {
            self.dismiss(animated: true, completion: nil)
        }
    }
    
    private func setupViews() {
        self.view.backgroundColor = .black.withAlphaComponent(0.5)
        
        self.view.addSubview(self.actionSheetBackgroundView)
        self.actionSheetBackgroundView.addSubview(self.descriptionLabel)
        self.actionSheetBackgroundView.addSubview(self.buttonsBackgroundStackView)
        self.buttonsBackgroundStackView.addArrangedSubview(cancelButton)
        self.buttonsBackgroundStackView.addArrangedSubview(closeButton)
        
        self.actionSheetBackgroundView.snp.makeConstraints { maker in
            maker.leading.trailing.equalToSuperview()
            maker.height.equalTo(270)
            self.actionSheetBottomConstraint = maker.top.equalTo(self.view.snp.bottom).constraint
            self.actionSheetBottomConstraint?.activate()
        }
        
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
    
    fileprivate func showActionSheet() {
        self.view.alpha = 1
        self.actionSheetBottomConstraint?.update(inset: self.actionSheetBackgroundView.frame.height)
    }
    
    fileprivate func hideActionSheet() {
        self.view.alpha = 0
        self.actionSheetBottomConstraint?.update(inset: 0)
    }
}

extension CloseEditActionSheetViewController: UIViewControllerTransitioningDelegate, UIViewControllerAnimatedTransitioning {
    
    func animationController(forPresented presented: UIViewController, presenting: UIViewController, source: UIViewController) -> UIViewControllerAnimatedTransitioning? {
        return self
    }
    
    func animationController(forDismissed dismissed: UIViewController) -> UIViewControllerAnimatedTransitioning? {
        return self
    }
    
    func transitionDuration(using transitionContext: UIViewControllerContextTransitioning?) -> TimeInterval {
        return 1
    }
    
    func animateTransition(using transitionContext: UIViewControllerContextTransitioning) {
        let containerView = transitionContext.containerView
        let toViewController = transitionContext.viewController(forKey: UITransitionContextViewControllerKey.to)
        guard let toVC = toViewController else { return }
        self.isPresenting = !self.isPresenting
        
        self.view.layoutIfNeeded()
        if isPresenting {
            containerView.addSubview(toVC.view)
            UIView.animate(withDuration: 0.2, delay: 0, options: [.curveEaseOut], animations: {
                self.showActionSheet()
                self.view.layoutIfNeeded()
            }, completion: { (finished) in
                transitionContext.completeTransition(true)
            })
        } else {
            UIView.animate(withDuration: 0.2, delay: 0, options: [.curveEaseOut], animations: {
                self.hideActionSheet()
                self.view.layoutIfNeeded()
            }, completion: { (finished) in
                transitionContext.completeTransition(true)
            })
        }
    }
}
