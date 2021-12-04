//
//  LabelTextFieldView.swift
//  90s
//
//  Created by woongs on 2021/10/16.
//

import UIKit

class LabelTextFieldView: UIView {
    
    struct UnderLine {
        var width: CGFloat = 0
        var color: UIColor = .clear
    }
    
    let label: UILabel = {
        let label = UILabel()
        label.setContentHuggingPriority(.defaultHigh, for: .horizontal)
        label.setContentCompressionResistancePriority(.defaultHigh, for: .horizontal)
        return label
    }()
    
    let textField: UITextField = {
        let textField = UITextField()
        return textField
    }()
    
    var underline = UnderLine() {
        didSet {
            let underline = self.underline
            self.underlineView.snp.makeConstraints { maker in
                maker.height.equalTo(underline.width)
            }
            self.underlineView.backgroundColor = self.underline.color
        }
    }
    
    var inset: UIEdgeInsets = .zero {
        didSet {
            let inset = self.inset
            self.contentView.snp.updateConstraints { maker in
                maker.top.equalToSuperview().inset(inset.top)
                maker.leading.equalToSuperview().inset(inset.left)
                maker.trailing.equalToSuperview().inset(inset.right)
            }
            self.underlineView.snp.updateConstraints { maker in
                maker.bottom.equalToSuperview().inset(inset.bottom)
            }
        }
    }
    
    var labelTrailingSpacing: CGFloat = 30 {
        didSet {
            let spacing = self.labelTrailingSpacing
            self.textField.snp.updateConstraints { maker in
                maker.leading.equalTo(self.label.snp.trailing).offset(spacing)
            }
        }
    }
    
    private let contentView: UIView = {
        let view = UIView()
        return view
    }()
    
    private let underlineView: UIView = {
        let view = UIView()
        return view
    }()
    
    init(label: String?, placeholder: String?) {
        super.init(frame: .zero)
        self.label.text = label
        self.label.isHidden = (label?.isEmpty) ?? true
        self.textField.placeholder = placeholder
        self.setupViews()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setupViews() {
        self.addSubview(self.contentView)
        self.addSubview(self.underlineView)
        self.contentView.addSubview(self.label)
        self.contentView.addSubview(self.textField)
        
        self.contentView.snp.makeConstraints { maker in
            maker.top.equalToSuperview()
            maker.leading.trailing.equalToSuperview()
            maker.bottom.equalTo(self.underlineView.snp.top)
        }
        
        self.label.snp.makeConstraints { maker in
            maker.top.leading.bottom.equalToSuperview()
        }
        
        self.textField.snp.makeConstraints { maker in
            maker.top.trailing.bottom.equalToSuperview()
            maker.leading.equalTo(self.label.snp.trailing).offset(self.labelTrailingSpacing)
        }
        
        self.underlineView.snp.makeConstraints { maker in
            maker.leading.trailing.equalTo(self.contentView)
            maker.bottom.equalToSuperview()
        }
    }
}
