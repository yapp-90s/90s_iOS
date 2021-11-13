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
        let albumVC = AlbumViewController(viewModel: AlbumsViewModel(dependency: .init(albumRepository: .shared)))
        let naviVC = UINavigationController(rootViewController: albumVC)
        albumVC.tabBarItem = UITabBarItem(title: "Album", image: nil, tag: 0)
        
        let filmVC = BaseNavigationControllerViewController(rootViewController: FilmMainViewController()) 
        filmVC.tabBarItem = UITabBarItem(title: "Film", image: nil, tag: 1)
        
        let profileVC = BaseNavigationControllerViewController(rootViewController: ProfileViewController())
        profileVC.tabBarItem = UITabBarItem(title: "Profile", image: nil, tag: 2)
        
        let tabList = [
            naviVC,
            filmVC,
            profileVC
        ]
        
        viewControllers = tabList
    }
}
