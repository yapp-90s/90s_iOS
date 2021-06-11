//
//  AddAlbumViewController.swift
//  90s
//
//  Created by woong on 2021/02/07.
//

import UIKit

class AddAlbumViewController: BaseViewController {
    
    private struct Constraints {
        static let supplementaryHeight: CGFloat = 215
        static let addingContentsHeight: CGFloat = 74
    }
    
    // MARK: - Views
    
    private var photoDecorateView: UIView = {
        let view = UIView()
        
        return view
    }()
    
    private let photoView: RatioBasedImageView = {
        let photoView = RatioBasedImageView()
        photoView.isUserInteractionEnabled = true
        
        return photoView
    }()
    
    private var supplementaryView: UIView = {
        let view = UIView()
        
        return view
    }()
    
    private var addingContentsView: UIView = {
        let view = UIView()
        
        return view
    }()
    
    private var addToAlbumButton: UIButton = {
        let button = UIButton()
        button.semanticContentAttribute = .forceRightToLeft
        button.setImage(UIImage(named: "ic_rightArrow"), for: .normal)
        button.setTitle("앨범에 넣기 ", for: .normal)
        button.backgroundColor = .retroOrange
        button.contentEdgeInsets = .init(top: 0, left: 32, bottom: 0, right: 22)
        button.layer.cornerRadius = 6
        
        return button
    }()
    
    private var downloadButton: CenterVerticallyButton = {
        let button = CenterVerticallyButton()
        button.setImage(UIImage(named: "ic_download"), for: .normal)
        button.setTitle("다운로드", for: .normal)
        button.titleLabel?.font = .systemFont(ofSize: 12)
        
        return button
    }()
    
    private var shareButton: CenterVerticallyButton = {
        let button = CenterVerticallyButton()
        button.setImage(UIImage(named: "ic_share"), for: .normal)
        button.setTitle("공유하기", for: .normal)
        button.titleLabel?.font = .systemFont(ofSize: 12)
        
        return button
    }()
    
    // MARK: - View Life Cycle
    
    init(image: UIImage) {
        super.init(nibName: nil, bundle: nil)
        photoView.image = image
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupViews()
        setupLayouts()
    }
    
    // MARK: - Initialize
    
    private func setupViews() {
        view.addSubview(photoDecorateView)
        view.addSubview(supplementaryView)
        [photoView].forEach { photoDecorateView.addSubview($0) }
        supplementaryView.addSubview(addingContentsView)
        [addToAlbumButton, downloadButton, shareButton].forEach { addingContentsView.addSubview($0) }
    }
    
    private func setupLayouts() {
        supplementaryView.snp.makeConstraints {
            $0.height.equalTo(Constraints.supplementaryHeight)
            $0.leading.equalTo(view.safeAreaLayoutGuide.snp.leading)
            $0.trailing.equalTo(view.safeAreaLayoutGuide.snp.trailing)
            $0.bottom.equalTo(view.safeAreaLayoutGuide.snp.bottom)
        }
        
        addingContentsView.snp.makeConstraints {
            $0.leading.trailing.equalToSuperview()
            $0.bottom.equalTo(-35)
            $0.height.equalTo(Constraints.addingContentsHeight)
        }
        
        addToAlbumButton.snp.makeConstraints {
            $0.top.equalTo(10)
            $0.bottom.equalTo(-10)
            $0.trailing.equalTo(-18)
        }
        
        downloadButton.snp.makeConstraints {
            $0.top.equalTo(8)
            $0.bottom.equalTo(-10)
            $0.leading.equalTo(18)
        }
        
        shareButton.snp.makeConstraints {
            $0.top.equalTo(8)
            $0.bottom.equalTo(-10)
            $0.leading.equalTo(downloadButton.snp.trailing)
        }

        photoDecorateView.snp.makeConstraints {
            $0.top.equalTo(view.safeAreaLayoutGuide.snp.top)
            $0.leading.equalTo(view.safeAreaLayoutGuide.snp.leading)
            $0.trailing.equalTo(view.safeAreaLayoutGuide.snp.trailing)
            $0.bottom.equalTo(supplementaryView.snp.top)
        }
        
        photoView.snp.makeConstraints {
            $0.centerY.equalToSuperview()
            $0.top.greaterThanOrEqualToSuperview()
            $0.bottom.lessThanOrEqualToSuperview()
        }
    }
}
