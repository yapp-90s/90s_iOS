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
        let albumVC = AlbumViewController()
        albumVC.tabBarItem = UITabBarItem(title: "Album", image: nil, tag: 0)
        
        let filmVC = FilmVC()
        filmVC.tabBarItem = UITabBarItem(title: "Film", image: nil, tag: 1)
        
        let filmListVC = FilmListVC()
        filmListVC.tabBarItem = UITabBarItem(title: "FilmList", image: nil, tag: 2)
        
        let tabList = [
            albumVC,
            filmVC,
            filmListVC
        ]
        
        viewControllers = tabList
    }
}
