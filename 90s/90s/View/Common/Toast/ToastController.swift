//
//  ToastController.swift
//  90s
//
//  Created by woongs on 2022/01/01.
//

import UIKit

class ToastController {
    
    enum Position {
        case top(offset: CGFloat)
        case bottom(inset: CGFloat)
        case point(origin: CGPoint)
    }
    
    static let shared = ToastController()
    
    let toastView = ToastView()
    let defaultConfiguration = ToastConfiguration(
        backgroundColor: .retroPink,
        cornerRadius: 6,
        textColor: .white,
        numberOfLines: 0,
        font: .Small_Text_Bold
    )
    
    private(set) var isShowing: Bool = false
    private var displayView: UIView?
    
    func showToast(message: String,
                   delay: CGFloat = 0,
                   duration: CGFloat = 1.5,
                   position: Position = .top(offset: 0),
                   configuration: ToastConfiguration? = nil,
                   on displayView: UIView? = UIApplication.shared.topViewController?.view) {
        guard let displayView = displayView, !isShowing else { return }
        self.toastView.update(message: message, configuration: configuration ?? self.defaultConfiguration)
        self.addToast(to: position, on: displayView)
        
        self.toastView.alpha = 1
        self.isShowing = true
        UIView.animate(
            withDuration: duration,
            delay: delay,
            animations: {
                self.toastView.alpha = 0
            }, completion: { isFinished in
                self.toastView.removeFromSuperview()
                self.displayView = nil
                self.isShowing = false
            }
        )
    }
    
    private func addToast(to position: Position, on displayView: UIView) {
        displayView.addSubview(self.toastView)
        self.displayView = displayView
        
        switch position {
        case .top(let offset):
            self.toastView.snp.makeConstraints { maker in
                maker.top.equalTo(displayView.safeAreaLayoutGuide.snp.top).offset(offset)
                maker.centerX.equalToSuperview()
            }
        case .bottom(let inset):
            self.toastView.snp.makeConstraints { maker in
                maker.bottom.equalTo(displayView.safeAreaLayoutGuide.snp.bottom).offset(inset)
                maker.centerX.equalToSuperview()
            }
        case .point(let origin):
            self.toastView.snp.makeConstraints { maker in
                maker.top.equalTo(displayView.safeAreaLayoutGuide.snp.top).offset(origin.y)
                maker.leading.equalTo(displayView.safeAreaLayoutGuide.snp.leading).offset(origin.x)
            }
        }
    }
}
