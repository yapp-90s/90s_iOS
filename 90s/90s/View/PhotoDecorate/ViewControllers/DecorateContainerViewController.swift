//
//  PhotoDecorateViewController.swift
//  90s
//
//  Created by woong on 2021/02/07.
//

import UIKit
import SnapKit

class DecorateContainerViewController: BaseViewController {
    
    struct Constraints {
        static let supplementaryHeight: CGFloat = 215
    }
    
    // MARK: - Views
    
    private let photoDecoreateVC: PhotoDecorateViewController
    private let stickerPackVC: StickerPackListViewController
    private lazy var subNavigationController: UINavigationController = {
        let nav = UINavigationController(rootViewController: stickerPackVC)
        return nav
    }()
    
    private var photoDecorateView: UIView = {
        let view = UIView()
        
        return view
    }()
    
    private var supplementaryView: UIView = {
        let view = UIView()
        
        return view
    }()
    
    // MARK: - Properties
    
    let viewModel: DecorateContainerViewModel
    
    // MARK: - View Life Cycle
    
    init(_ viewModel: DecorateContainerViewModel) {
        self.viewModel = viewModel
        photoDecoreateVC = PhotoDecorateViewController(viewModel: viewModel.output.photoDecorateViewModel)
        stickerPackVC = StickerPackListViewController(viewModel.output.stickerPackListViewModel)
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupViews()
        setupLayouts()
        setBarButtonItem(type: .imgCheck, position: .right, action: #selector(tappedCheckButton))
    }
    
    // MARK: - Initialize
    
    private func setupViews() {
        title = "사진 선택"
        view.addSubview(photoDecorateView)
        view.addSubview(supplementaryView)
        
        addChild(photoDecoreateVC)
        addChild(subNavigationController)
        
        photoDecorateView.addSubview(photoDecoreateVC.view)
        supplementaryView.addSubview(subNavigationController.view)
        
        photoDecoreateVC.didMove(toParent: self)
        subNavigationController.didMove(toParent: self)
    }
    
    private func setupLayouts() {
        supplementaryView.snp.makeConstraints {
            $0.height.equalTo(Constraints.supplementaryHeight)
            $0.leading.equalTo(view.safeAreaLayoutGuide.snp.leading)
            $0.trailing.equalTo(view.safeAreaLayoutGuide.snp.trailing)
            $0.bottom.equalTo(view.safeAreaLayoutGuide.snp.bottom)
        }

        photoDecorateView.snp.makeConstraints {
            $0.top.equalTo(view.safeAreaLayoutGuide.snp.top)
            $0.leading.equalTo(view.safeAreaLayoutGuide.snp.leading)
            $0.trailing.equalTo(view.safeAreaLayoutGuide.snp.trailing)
            $0.bottom.equalTo(supplementaryView.snp.top)
        }
        
        photoDecoreateVC.view.snp.makeConstraints {
            $0.edges.equalToSuperview()
        }
        
        subNavigationController.view.snp.makeConstraints {
            $0.edges.equalToSuperview()
        }
    }
    
    @objc private func tappedCheckButton() {
        photoDecoreateVC.viewModel.input.changeResizableOfAllStickers.onNext(false)
        let image = photoDecoreateVC.renderDecoratedImage()
        
        navigationController?.pushViewController(AddAlbumViewController(image: image), animated: true)
    }
}
