//
//  PhotoDecorateViewController.swift
//  90s
//
//  Created by woong on 2021/02/07.
//

import UIKit
import SnapKit

class DecorateContainerViewController: BaseViewController {
    
    // MARK: - Properties
    
    // MARK: - Views
    
    private var photoDecoreateVC = PhotoDecorateViewController()
    private var stickerPackVC = StickerPackListViewController()
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
    
    // MARK: - View Life Cycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupViews()
        setupLayouts()
    }
    
    // MARK: - Initialize
    
    private func setupViews() {
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
            $0.height.equalTo(250)
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
}
