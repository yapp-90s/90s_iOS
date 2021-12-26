//
//  SceneDelegate.swift
//  90s
//
//  Created by 성다연 on 2020/11/01.
//

import UIKit
import RxKakaoSDKAuth
import KakaoSDKAuth

protocol AppRootDelegate: AnyObject {
    func switchToMain()
    func switchToLogin()
}

class SceneDelegate: UIResponder, UIWindowSceneDelegate, AppRootDelegate {
    
    var window: UIWindow?

    func scene(_ scene: UIScene, willConnectTo session: UISceneSession, options connectionOptions: UIScene.ConnectionOptions) {
        guard let windowScene = (scene as? UIWindowScene) else { return }
        window = UIWindow(frame: UIScreen.main.bounds)
        window?.windowScene = windowScene
        window?.makeKeyAndVisible()
        window?.overrideUserInterfaceStyle = .dark
        let loginViewController = LoginViewController(viewModel: .init(dependency: .init()))
        loginViewController.appRootDelegate = self
        window?.rootViewController = MainTabBarController()
    }
    
    func scene(_ scene: UIScene, openURLContexts URLContexts: Set<UIOpenURLContext>) {
        if let url = URLContexts.first?.url, (AuthApi.isKakaoTalkLoginUrl(url)) {
            _ = AuthController.rx.handleOpenUrl(url: url)
        }
    }
    
    // MARK: - AppRootDelegate
    
    func switchToMain() {
        self.window?.rootViewController = MainTabBarController()
        self.window?.rootViewController?.view.alpha = 0
        UIView.animate(withDuration: 1, delay: 0, options: .curveEaseInOut) {
            self.window?.rootViewController?.view.alpha = 1
        }
    }
    
    func switchToLogin() {
        self.window?.rootViewController = LoginViewController(viewModel: .init(dependency: .init()))
        self.window?.rootViewController?.view.alpha = 0
        UIView.animate(withDuration: 1, delay: 0, options: .curveEaseInOut) {
            self.window?.rootViewController?.view.alpha = 1
        }
    }
}

