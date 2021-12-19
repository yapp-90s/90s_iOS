//
//  ProfileSettingTableViewCell.swift
//  90s
//
//  Created by 성다연 on 2021/07/08.
//

import UIKit
import SnapKit
import RxSwift

final class ProfileSettingTableViewCellViewModel {
    
    var title: String
    var switchObservable: Observable<Bool>?
    var toggleSwitchPublisher: PublishSubject<Bool>?
    
    init(
        title: String,
        switchObservable: Observable<Bool>? = nil,
        toggleSwitchPublisher: PublishSubject<Bool>? = nil
    ) {
        self.title = title
        self.switchObservable = switchObservable
        self.toggleSwitchPublisher = toggleSwitchPublisher
    }
}

class ProfileSettingTableViewCell: UITableViewCell {
    
    private let titleLabel : UILabel = {
        let label = UILabel(frame: .zero)
        label.font = .Profile_Menu_Text
        label.text = "Title"
        return label
    }()
    
    private var switchButton: UISwitch = {
        let switchButton = UISwitch(frame: .zero)
        switchButton.onTintColor = .retroOrange
        return switchButton
    }()

    private let spacingView : UIView = {
        let view = UIView(frame: .zero)
        view.backgroundColor = .black
        return view
    }()
    
    var disposeBag = DisposeBag()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setUpSubviews()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setUpSubviews() {
        addSubview(titleLabel)
        addSubview(spacingView)
        
        backgroundColor = .colorRGBHex(hex: 0x222225)
        
        titleLabel.snp.makeConstraints {
            $0.centerY.equalTo(contentView.snp.centerY).offset(-2)
            $0.left.equalTo(contentView.safeAreaLayoutGuide).offset(8)
        }

        spacingView.snp.makeConstraints {
            $0.height.equalTo(4)
            $0.left.right.bottom.equalToSuperview()
        }
        
        self.accessoryView = switchButton
    }
    
    func bind(viewModel: ProfileSettingTableViewCellViewModel) {
        titleLabel.text = viewModel.title
        switchButton.isHidden = viewModel.switchObservable == nil
        
        viewModel.switchObservable?
            .bind(to: switchButton.rx.isOn)
            .disposed(by: disposeBag)
        
        switchButton.rx
            .isOn.changed
            .debounce(.milliseconds(800), scheduler: MainScheduler.instance)
            .distinctUntilChanged().asObservable()
            .subscribe(onNext: { isOn in
                guard let togglePublisher = viewModel.toggleSwitchPublisher else { return }
                togglePublisher.onNext(isOn)
            })
            .disposed(by: disposeBag)
    }
}
