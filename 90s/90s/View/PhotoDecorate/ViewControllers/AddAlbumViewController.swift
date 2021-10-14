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
    
    private let indicator: UIActivityIndicatorView = {
        let indicator = UIActivityIndicatorView(style: .large)
        indicator.hidesWhenStopped = true
        indicator.stopAnimating()
        
        return indicator
    }()
    
    // MARK: - Properties
    
    let viewModel: AddAlbumViewModel
    
    // MARK: - View Life Cycle
    
    init(_ viewModel: AddAlbumViewModel) {
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)
        bind()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupViews()
        setupLayouts()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
    }
    
    // MARK: - Initialize
    
    private func bind() {
        self.downloadButton.rx.tap
            .bind(to: viewModel.input.downloadImage)
            .disposed(by: self.disposeBag)
        
        self.shareButton.rx.tap
            .bind(to: self.viewModel.input.tappedShareButton)
            .disposed(by: self.disposeBag)
        
        self.viewModel.output.isLoading
            .bind(to: indicator.rx.isAnimating)
            .disposed(by: self.disposeBag)
        
        self.viewModel.output.showCloseEdit
            .subscribe(onNext: { [weak self] in
                self?.showCloseEditActionSheet()
            })
            .disposed(by: self.disposeBag)
        
        self.viewModel.output.showShareActionSheet
            .subscribe(onNext: { [weak self] in
                self?.showShareActionSheet()
            })
            .disposed(by: self.disposeBag)
    }
    
    private func setupViews() {
        let imageData = viewModel.output.decoratedImage.value
        photoView.image = UIImage(data: imageData)
        
        view.addSubview(photoDecorateView)
        view.addSubview(supplementaryView)
        photoDecorateView.addSubview(photoView)
        supplementaryView.addSubview(addingContentsView)
        [addToAlbumButton, downloadButton, shareButton].forEach { addingContentsView.addSubview($0) }
        photoView.addSubview(indicator)
        
        setBarButtonItem(type: .imgClose, position: .right, action: #selector(tappedCloseBarButton))
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
            $0.center.equalToSuperview()
            $0.top.greaterThanOrEqualToSuperview()
            $0.bottom.lessThanOrEqualToSuperview()
        }
        
        indicator.snp.makeConstraints {
            $0.center.equalToSuperview()
        }
    }
    
    private func showCloseEditActionSheet() {
        let closeEditActionSheetViewController = CloseEditActionSheetViewController(viewModel: CloseEditActionSheetViewModel(dependency: .init()))
        closeEditActionSheetViewController.modalPresentationStyle = .overFullScreen
        self.present(closeEditActionSheetViewController, animated: true, completion: nil)
    }
    
    private func showShareActionSheet() {
        let shareActionSheetViewController = ShareActionSheetViewController()
        shareActionSheetViewController.modalPresentationStyle = .overFullScreen
        self.present(shareActionSheetViewController, animated: true, completion: nil)
    }
    
    @objc private func tappedCloseBarButton() {
        self.viewModel.input.tappedCloseButton.onNext(())
    }
}
