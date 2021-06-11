//
//  DecorateViewController.swift
//  90s
//
//  Created by woong on 2021/02/07.
//

import UIKit

class PhotoDecorateViewController: BaseViewController {
    
    private struct Constraints {
        static let photoInset: UIEdgeInsets = .init(top: 40, left: 40, bottom: 40, right: 40)
    }
    
    private var decorator = StickerDecorator()
    
    // MARK: - Views
    
    private(set) var decoratingView: UIView = {
        let view = UIView()
        
        return view
    }()
    
    private(set) var decoratingBorderView: UIView = {
        let view = UIView()
        view.layer.borderColor = UIColor.white.cgColor
        view.layer.borderWidth = 1
        
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
        
    }
    
    private func setupViews() {
        view.addSubview(decoratingBorderView)
        decoratingBorderView.addSubview(decoratingView)
        decoratingView.addSubview(photoBackgroundView)
        decoratingView.addSubview(photoView)
        
        photoView.snp.makeConstraints {
            $0.centerY.equalToSuperview()
            $0.top.greaterThanOrEqualToSuperview()
            $0.bottom.lessThanOrEqualToSuperview()
            $0.leading.equalToSuperview().inset(Constraints.photoInset)
            $0.trailing.equalToSuperview().inset(Constraints.photoInset)
        }
        
        photoBackgroundView.snp.makeConstraints {
            $0.center.equalTo(photoView)
            $0.top.edges.equalTo(photoView).inset(-20)
        }
        
        decoratingBorderView.snp.makeConstraints {
            $0.leading.trailing.equalToSuperview()
            $0.top.bottom.equalTo(photoBackgroundView).inset(-20)
        }
        
        decoratingView.snp.makeConstraints {
            $0.edges.equalToSuperview()
        }
    }
    
    // MARK: - Methods
    
    func attachStickerView(_ sticker: ResizableStickerView, at position: CGPoint? = nil) {
        photoView.addSubview(sticker)
        sticker.center = position ?? photoView.center
        addMovingGesture(sticker)
        addResizingGesture(sticker)
    }
    
    func renderDecoratedImage() -> UIImage {
        let renderer = UIGraphicsImageRenderer(size: decoratingView.bounds.size)
        let image = renderer.image { context in
            decoratingView.drawHierarchy(in: decoratingView.bounds, afterScreenUpdates: true)
        }
        
        return image
    }
    
    // MARK: Private
    
    private func addMovingGesture(_ sticker: ResizableStickerView) {
        let panGesture = UIPanGestureRecognizer(target: self, action: #selector(moveSticker(_:)))
        
        sticker.addGestureRecognizer(panGesture)
    }
    
    @objc private func moveSticker(_ gesture: UIPanGestureRecognizer) {
        decorator.moveSticker(with: gesture, in: photoView)
    }
    
    private func addResizingGesture(_ sticker: ResizableStickerView) {
        sticker.resizeHandler = { [weak self] gesture, sticker in
            guard let self = self else { return }
            self.decorator.resizingSticker(sticker, with: gesture, in: self.photoView)
        }
    }
}
