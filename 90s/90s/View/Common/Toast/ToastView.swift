//
//  ToastView.swift
//  90s
//
//  Created by woongs on 2022/01/01.
//

import UIKit

struct ToastConfiguration {
    var backgroundColor: UIColor
    var cornerRadius: CGFloat
    var textColor: UIColor
    var numberOfLines: Int
    var font: UIFont
}

class ToastView: UIView {
    
    public func update(message: String?, configuration: ToastConfiguration) {
        self.message = message
        self.backgroundColor = configuration.backgroundColor
        self.layer.cornerRadius = configuration.cornerRadius
        self.messageLabel.textColor = configuration.textColor
        self.messageLabel.numberOfLines = configuration.numberOfLines
        self.messageLabel.font = configuration.font
    }
    
    private var message: String? {
        get { self.messageLabel.text }
        set { self.messageLabel.text = newValue }
    }

    private var messageLabel: UILabel = {
        let label = UILabel()
        label.textAlignment = .center
        return label
    }()
    
    init() {
        super.init(frame: .zero)
        self.setupViews()
    }
    
    deinit {
        print("deinit toastView")
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setupViews() {
        self.addSubview(messageLabel)
        self.messageLabel.snp.makeConstraints { maker in
            maker.top.equalToSuperview().offset(13)
            maker.leading.equalToSuperview().offset(32)
            maker.trailing.equalToSuperview().offset(-31)
            maker.bottom.equalToSuperview().offset(-14)
        }
    }
}
