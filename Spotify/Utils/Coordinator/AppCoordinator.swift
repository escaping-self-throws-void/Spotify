//
//  BaseCoordinator.swift
//  Spotify
//
//  Created by Paul Matar on 22/11/2022.
//

import UIKit

final class AppCoordinator: BaseCoordinator {
     
    private let window: UIWindow
        
    init(window: UIWindow) {
        self.window = window
    }
    
    override func start() {
        window.rootViewController = navigationController
        window.makeKeyAndVisible()
        
        let coordinator = LoginCoordinator()
        coordinator.navigationController = navigationController
        start(coordinator)
    }
}
