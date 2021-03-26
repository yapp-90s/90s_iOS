//
//  DecorateViewController.swift
//  90s
//
//  Created by woong on 2021/02/07.
//

import UIKit

class PhotoDecorateViewController: BaseViewController {
    
    struct Constraints {
        static let photoInset: UIEdgeInsets = .init(top: 0, left: 20, bottom: 0, right: 20)
    }
    
    // MARK: - Properties
    
    let viewModel: PhotoDecorateViewModel
    
    // MARK: - Views
    
    var decoratingView: DecoratingView = {
        let view = DecoratingView()
        
        return view
    }()
    
    let photoView: DecoratePhotoView = {
        let photoView = DecoratePhotoView(image: UIImage(named: "filmimg"))
        
        return photoView
    }()
    
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
                self.decoratingView.attachStickerView(stickerView)
            })
            .disposed(by: disposeBag)
        
        viewModel.output.photo
            .map { UIImage(named: $0.url) }
            .bind(to: photoView.imageView.rx.image)
            .disposed(by: disposeBag)
    }
    
    private func setupViews() {
        view.addSubview(decoratingView)
        decoratingView.addSubview(photoView)
        
        decoratingView.snp.makeConstraints {
            $0.edges.equalToSuperview()
        }
        
        photoView.snp.makeConstraints {
            $0.centerY.equalToSuperview()
            $0.leading.trailing.equalToSuperview().inset(Constraints.photoInset)
            $0.height.equalTo(photoView.snp.width)
        }
    }
    
    // MARK: - Methods
    
    func attachStickerView(_ sticker: ResizableStickerView, at position: CGPoint) {
        view.addSubview(sticker)
        sticker.center = position
    }
}
