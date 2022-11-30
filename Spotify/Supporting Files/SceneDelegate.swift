//
//  SceneDelegate.swift
//  Spotify
//
//  Created by Paul Matar on 22/11/2022.
//

import UIKit

class SceneDelegate: UIResponder, UIWindowSceneDelegate {

    var window: UIWindow?
    var appCoordinator: AppCoordinator?

    func scene(_ scene: UIScene, willConnectTo session: UISceneSession, options connectionOptions: UIScene.ConnectionOptions) {
        guard let scene = (scene as? UIWindowScene) else { return }
        let window = UIWindow(windowScene: scene)
        self.window = window
        window.overrideUserInterfaceStyle = .light
        
        appCoordinator = AppCoordinator(window: window)
        appCoordinator?.start()
        
        AuthManager.shared.refreshAccessToken { success in
            debugPrint(success)
        }
    }
}

