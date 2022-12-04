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
        window?.overrideUserInterfaceStyle = .dark
        
        configureUI()

        if AuthManager.shared.isSignedIn {
            let vm = SearchViewModelImpl(service: ApiService())
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
    
    private func configureUI() {
        let navigationBarAppearance = UINavigationBarAppearance()
        navigationBarAppearance.configureWithOpaqueBackground()
        navigationBarAppearance.titleTextAttributes = [
            .foregroundColor : UIColor.white
        ]
        navigationBarAppearance.shadowColor = .clear
        UINavigationBar.appearance().standardAppearance = navigationBarAppearance
        UINavigationBar.appearance().compactAppearance = navigationBarAppearance
        UINavigationBar.appearance().scrollEdgeAppearance = navigationBarAppearance
    }
}

