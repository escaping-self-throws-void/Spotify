//
//  SceneDelegate.swift
//  Spotify
//
//  Created by Paul Matar on 22/11/2022.
//

import UIKit

class SceneDelegate: UIResponder, UIWindowSceneDelegate {

    var window: UIWindow?

    func scene(_ scene: UIScene, willConnectTo session: UISceneSession, options connectionOptions: UIScene.ConnectionOptions) {
        
        guard let windowScene = (scene as? UIWindowScene) else { return }
        window = UIWindow(windowScene: windowScene)
        window?.makeKeyAndVisible()
        
        
        if AuthManager.shared.isSignedIn {
            let vm = SearchViewModelImpl()
            let vc = SearchViewController(vm)
            let navVC = UINavigationController(rootViewController: vc)
            window?.rootViewController = navVC
        } else {
            let vc = LoginViewController()
            let navVC = UINavigationController(rootViewController: vc)
            window?.rootViewController = navVC
        }
        
        AuthManager.shared.refreshAccessToken { success in
            debugPrint(success)
        }
    }
}

