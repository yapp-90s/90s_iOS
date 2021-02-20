//
//  PhotoDecorateViewController.swift
//  90s
//
//  Created by woong on 2021/02/07.
//

import UIKit
import SnapKit

class DecorateContainerViewController: UIViewController {
    
    private var photoDecoreateVC = PhotoDecorateViewController()
    private var stickerPackVC = StickerPackViewController()
    private var stickersVC = StickersViewController()
    private var addAlbumVC = AddAlbumViewController()
    
    private var photoDecorateView: UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    private var supplementaryView: UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupViews()
    }
    
    private func setupViews() {
        view.addSubview(photoDecorateView)
        view.addSubview(supplementaryView)
        
        addChild(photoDecoreateVC)
        addChild(stickerPackVC)
        
        stickerPackVC.tapHandler = { [unowned self] in
            self.stickerPackVC.willMove(toParent: nil)
            self.stickerPackVC.view.removeFromSuperview()
            self.stickerPackVC.removeFromParent()
            
            addChild(stickersVC)
            self.supplementaryView.addSubview(self.stickersVC.view)
            self.stickersVC.didMove(toParent: self)
            
            self.stickersVC.view.snp.makeConstraints {
                $0.edges.equalToSuperview()
            }
        }
        
        photoDecorateView.addSubview(photoDecoreateVC.view)
        supplementaryView.addSubview(stickerPackVC.view)
        photoDecoreateVC.didMove(toParent: self)
        stickerPackVC.didMove(toParent: self)
        
        photoDecorateView.snp.makeConstraints {
            $0.top.equalTo(view.safeAreaLayoutGuide.snp.top)
            $0.leading.equalTo(view.safeAreaLayoutGuide.snp.leading)
            $0.trailing.equalTo(view.safeAreaLayoutGuide.snp.trailing)
            $0.height.equalTo(view.safeAreaLayoutGuide.snp.height).multipliedBy(0.6)
        }
        
        supplementaryView.snp.makeConstraints {
            $0.top.equalTo(photoDecorateView.snp.bottom)
            $0.leading.equalTo(view.safeAreaLayoutGuide.snp.leading)
            $0.trailing.equalTo(view.safeAreaLayoutGuide.snp.trailing)
            $0.bottom.equalTo(view.safeAreaLayoutGuide.snp.bottom)
        }
        
        photoDecoreateVC.view.snp.makeConstraints {
            $0.edges.equalToSuperview()
        }
        
        stickerPackVC.view.snp.makeConstraints {
            $0.edges.equalToSuperview()
        }
    }
}
