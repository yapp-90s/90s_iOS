//
//  MainTabBarController.swift
//  90s
//
//  Created by 김진우 on 2021/02/20.
//

import UIKit

class MainTabBarController: UITabBarController {

    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupUI()
    }
    
    private func setupUI() {
        let albumVC = AlbumViewController(viewModel: AlbumsViewModel(dependency: .init()))
        let naviVC = UINavigationController(rootViewController: albumVC)
        albumVC.tabBarItem = UITabBarItem(title: "Album", image: nil, tag: 0)
        
        let filmVC = UINavigationController(rootViewController: FilmMainViewController())
        filmVC.tabBarItem = UITabBarItem(title: "Film", image: nil, tag: 1)
        
        let tabList = [
            naviVC,
            filmVC
        ]
        
        viewControllers = tabList
    }
}
