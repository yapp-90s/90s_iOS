//
//  DecorateViewController.swift
//  90s
//
//  Created by woong on 2021/02/07.
//

import UIKit

class PhotoDecorateViewController: BaseViewController, UIScrollViewDelegate {
    
    private struct Constraints {
        static let photoInset: UIEdgeInsets = .init(top: 20, left: 20, bottom: 20, right: 20)
    }
    
    private var decorator = StickerDecorator()
    
    // MARK: - Views
    
    private lazy var scrollView: UIScrollView = {
        let scrollView = UIScrollView()
        scrollView.showsVerticalScrollIndicator = false
        scrollView.showsHorizontalScrollIndicator = false
        scrollView.minimumZoomScale = self.minimumZoomScale
        scrollView.maximumZoomScale = self.maximumZoomScale
        scrollView.bouncesZoom = false
        scrollView.delegate = self
        return scrollView
    }()
    
    private let contentView: UIView = {
        let view = UIView()
        
        return view
    }()
    
    private let decoratingAreaView: UIView = {
        let view = UIView()
        view.layer.borderColor = UIColor.white.cgColor
        view.layer.borderWidth = 1
        
        return view
    }()
    
    private let decoratingView: UIView = {
        let view = UIView()
        view.backgroundColor = .clear
        
        return view
    }()
    
    private let decoratingContentView: UIView = {
        let view = UIView()
        
        return view
    }()
    
    private let photoBackgroundView: UIView = {
        let view = UIView()
        view.backgroundColor = .white
        
        return view
    }()
    
    private let photoView: RatioBasedImageView = {
        let photoView = RatioBasedImageView()
        photoView.clipsToBounds = false
        photoView.isUserInteractionEnabled = true

        return photoView
    }()
    
    // MARK: - Properties
    
    unowned let viewModel: PhotoDecorateViewModel
    var minimumZoomScale = 0.7
    var maximumZoomScale = 1.0
    
    // MARK: - Initialize
    
    init(viewModel: PhotoDecorateViewModel) {
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)
        
        bindViewModel()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        setupViews()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        viewModel.input.viewWillAppear.onNext(())
    }
    
    private func bindViewModel() {
        
        viewModel.input.addSticker
            .map { ResizableStickerView(image: UIImage(named: $0.imageName)) }
            .subscribe(onNext: { [weak self] stickerView in
                guard let self = self else { return }
                self.attachStickerView(stickerView)
            })
            .disposed(by: disposeBag)
        
        viewModel.output.photo
            .map { UIImage(named: $0.url) ?? UIImage(named: "test_pic3") }
            .bind(to: photoView.rx.image)
            .disposed(by: disposeBag)
        
        viewModel.output.isResizableStickers
            .asDriver(onErrorJustReturn: true)
            .drive(onNext: { [weak self] resizable in
                self?.photoView.subviews.forEach {
                    guard let sticker = $0 as? ResizableStickerView else { return }
                    sticker.isResizable = resizable
                }
            })
            .disposed(by: disposeBag)
        
        viewModel.output.renderDecoratedImage
            .subscribe(onNext: { [weak self] _ in
                guard let imageData = self?.renderDecoratedImage() else { return }
                self?.viewModel.input.decoratedImage.onNext(imageData)
            })
            .disposed(by: disposeBag)
        
    }
    
    private func setupViews() {
        view.addSubview(scrollView)
        scrollView.addSubview(contentView)
        contentView.addSubview(decoratingAreaView)
        decoratingAreaView.addSubview(decoratingView)
        decoratingView.addSubview(decoratingContentView)
        decoratingContentView.addSubview(photoBackgroundView)
        decoratingContentView.addSubview(photoView)
        
        scrollView.snp.makeConstraints {
            $0.edges.equalToSuperview()
        }
        
        contentView.snp.makeConstraints {
            $0.edges.equalTo(scrollView.contentLayoutGuide)
        }
        
        decoratingAreaView.snp.makeConstraints {
            $0.edges.equalToSuperview()
        }
        
        decoratingView.snp.makeConstraints {
            $0.edges.equalToSuperview()
        }
        
        decoratingContentView.snp.makeConstraints {
            $0.edges.equalToSuperview()
            $0.center.equalTo(scrollView.frameLayoutGuide)
        }
        
        photoBackgroundView.snp.makeConstraints {
            $0.leading.trailing.greaterThanOrEqualToSuperview().inset(20)
            $0.top.greaterThanOrEqualToSuperview().inset(20)
            $0.bottom.lessThanOrEqualToSuperview().inset(20)
            $0.center.equalToSuperview()
        }
        
        photoView.snp.makeConstraints {
            $0.edges.equalTo(photoBackgroundView).inset(Constraints.photoInset)
        }
    }
    
    // MARK: - Methods
    
    func attachStickerView(_ sticker: ResizableStickerView, at position: CGPoint? = nil) {
        decoratingContentView.addSubview(sticker)
        sticker.center = position ?? photoView.center
        addMovingGesture(sticker)
        addResizingGesture(sticker)
    }
    
    func renderDecoratedImage() -> Data {
        return decorator.renderDecoratedView(self.decoratingView, in: self.decoratingView.bounds)
    }
    
    // MARK: Private
    
    private func addMovingGesture(_ sticker: ResizableStickerView) {
        let panGesture = UIPanGestureRecognizer(target: self, action: #selector(moveSticker(_:)))
        sticker.addGestureRecognizer(panGesture)
    }
    
    @objc private func moveSticker(_ gesture: UIPanGestureRecognizer) {
        decorator.moveSticker(with: gesture, in: self.decoratingContentView)
    }
    
    private func addResizingGesture(_ sticker: ResizableStickerView) {
        sticker.resizeHandler = { [weak self] gesture, sticker in
            guard let self = self else { return }
            self.decorator.resizingSticker(sticker, with: gesture, in: self.decoratingContentView)
        }
    }
    
    // MARK: - ScrollViewDelegate
    func viewForZooming(in scrollView: UIScrollView) -> UIView? {
        return self.decoratingContentView
    }
    
    func scrollViewDidZoom(_ scrollView: UIScrollView) {
        decoratingContentView.center = scrollView.center
    }
}
