//
//  DecorateViewController.swift
//  90s
//
//  Created by woong on 2021/02/07.
//

import UIKit

class PhotoDecorateViewController: BaseViewController {
    
    private struct Constraints {
        static let photoInset: UIEdgeInsets = .init(top: 20, left: 20, bottom: 20, right: 20)
    }
    
    private var decorator = StickerDecorator()
    
    // MARK: - Views
    
    private(set) var decoratingView: UIView = {
        let view = UIView()
        view.layer.borderColor = UIColor.white.cgColor
        view.layer.borderWidth = 1
        
        return view
    }()
    
    let photoView: RatioBasedImageView = {
        let photoView = RatioBasedImageView()
        photoView.isUserInteractionEnabled = true
        photoView.layer.borderWidth = 20
        photoView.layer.borderColor = UIColor.white.cgColor
        
        return photoView
    }()
    
    // MARK: - Properties
    
    let viewModel: PhotoDecorateViewModel
    
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
    
    private func bindViewModel() {
        
        viewModel.input.addSticker
            .map { ResizableStickerView(image: UIImage(named: $0.imageName)) }
            .subscribe(onNext: { [weak self] stickerView in
                guard let self = self else { return }
                self.attachStickerView(stickerView)
            })
            .disposed(by: disposeBag)
        
        viewModel.output.photo
            .map { UIImage(named: $0.url) ?? UIImage(named: "icon_trash") }
            .bind(to: photoView.rx.image)
            .disposed(by: disposeBag)
    }
    
    private func setupViews() {
        view.addSubview(decoratingView)
        view.addSubview(photoView)
        
        photoView.snp.makeConstraints {
            $0.centerY.equalToSuperview()
            $0.top.greaterThanOrEqualToSuperview()
            $0.bottom.lessThanOrEqualToSuperview()
            $0.leading.equalToSuperview().inset(Constraints.photoInset)
            $0.trailing.equalToSuperview().inset(Constraints.photoInset)
        }
        
        decoratingView.snp.makeConstraints {
            $0.leading.trailing.equalToSuperview()
            $0.top.bottom.equalTo(photoView).inset(-20)
        }
    }
    
    // MARK: - Methods
    
    func attachStickerView(_ sticker: ResizableStickerView, at position: CGPoint? = nil) {
        photoView.addSubview(sticker)
        sticker.center = position ?? photoView.center
        addMovingGesture(sticker)
        addResizingGesture(sticker)
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
