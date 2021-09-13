//
//  ActionSheetViewController.swift
//  90s
//
//  Created by kakao on 2021/09/12.
//

import UIKit
import SnapKit

protocol ActionSheetViewControllerType: UIViewControllerTransitioningDelegate, UIViewControllerAnimatedTransitioning {
    
    var isPresenting: Bool { get set }
    var transitionDuration: TimeInterval { get set }
    var actionSheetHeight: CGFloat { get set }
    
    func touchedBackgroundView()
    func showActionSheet(withDuration duration: TimeInterval,
                         delay: TimeInterval,
                         options: UIView.AnimationOptions,
                         animations: @escaping () -> Void, completion: ((Bool) -> Void)?)
    func hideActionSheet(withDuration duration: TimeInterval,
                         delay: TimeInterval,
                         options: UIView.AnimationOptions,
                         animations: @escaping () -> Void, completion: ((Bool) -> Void)?)
}

class ActionSheetViewController: BaseViewController, ActionSheetViewControllerType {
    
    var actionSheetContentView: UIView = {
        let view = UIView()
        view.backgroundColor = .Cool_Gray
        return view
    }()
    
    // MARK: - Properties
    
    var isPresenting = false
    var transitionDuration: TimeInterval = 1
    var actionSheetHeight: CGFloat = 0 {
        didSet {
            self.actionSheetHeightConstraint?.update(offset: self.actionSheetHeight)
        }
    }
    
    // MARK: - Private
    
    fileprivate var transitionContext: UIViewControllerContextTransitioning?
    fileprivate var actionSheetTopConstraint: Constraint?
    fileprivate var actionSheetHeightConstraint: Constraint?
    
    // MARK: - View LifeCycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = .black.withAlphaComponent(0.5)
        self.actionSheetSetup()
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        if let touch = touches.first, touch.view == self.view {
            self.touchedBackgroundView()
        }
        super.touchesBegan(touches, with: event)
    }
    
    private func actionSheetSetup() {
        self.transitioningDelegate = self
        self.view.addSubview(self.actionSheetContentView)
        
        self.actionSheetContentView.snp.makeConstraints { maker in
            maker.leading.trailing.equalToSuperview()
            self.actionSheetHeightConstraint = maker.height.equalTo(self.actionSheetHeight).constraint
            self.actionSheetTopConstraint = maker.top.equalTo(self.view.snp.bottom).constraint
            self.actionSheetHeightConstraint?.activate()
            self.actionSheetTopConstraint?.activate()
        }
    }
    
    // MARK: - Methods
    
    func touchedBackgroundView() {
        self.dismiss(animated: true, completion: nil)
    }
    
    func showActionSheet(withDuration duration: TimeInterval = 0.2,
                         delay: TimeInterval = 0,
                         options: UIView.AnimationOptions = [],
                         animations: @escaping () -> Void,
                         completion: ((Bool) -> Void)? = nil) {
        
        self.view.layoutIfNeeded()
        UIView.animate(withDuration: duration, delay: delay, options: options, animations: {
            animations()
            self.actionSheetTopConstraint?.update(inset: self.actionSheetHeight)
            self.view.layoutIfNeeded()
        }, completion: { (finished) in
            self.transitionContext?.completeTransition(true)
        })
    }
    
    func hideActionSheet(withDuration duration: TimeInterval = 0.2,
                         delay: TimeInterval = 0,
                         options: UIView.AnimationOptions = [],
                         animations: @escaping () -> Void, completion: ((Bool) -> Void)? = nil) {
        self.view.layoutIfNeeded()
        UIView.animate(withDuration: duration, delay: delay, options: options, animations: {
            animations()
            self.actionSheetTopConstraint?.update(inset: 0)
            self.view.layoutIfNeeded()
        }, completion: { (finished) in
            self.transitionContext?.completeTransition(true)
        })
    }
    
    // MARK: - UIViewControllerTransitioningDelegate, UIViewControllerAnimatedTransitioning
    
    func animationController(forPresented presented: UIViewController, presenting: UIViewController, source: UIViewController) -> UIViewControllerAnimatedTransitioning? {
        return self
    }
    
    func animationController(forDismissed dismissed: UIViewController) -> UIViewControllerAnimatedTransitioning? {
        return self
    }
    
    @objc(transitionDuration:) func transitionDuration(using transitionContext: UIViewControllerContextTransitioning?) -> TimeInterval {
        return self.transitionDuration
    }
    
    @objc(animateTransition:) func animateTransition(using transitionContext: UIViewControllerContextTransitioning) {
        self.transitionContext = transitionContext
        let containerView = transitionContext.containerView
        let toViewController = transitionContext.viewController(forKey: UITransitionContextViewControllerKey.to)
        guard let toVC = toViewController else { return }
        self.isPresenting = !self.isPresenting

        
        if self.isPresenting {
            containerView.addSubview(toVC.view)
            self.showActionSheet(animations: { })
        } else {
            self.hideActionSheet(animations: { })
        }
    }
}
