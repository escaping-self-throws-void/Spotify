//
//  LoginCoordinator.swift
//  Spotify
//
//  Created by Paul Matar on 22/11/2022.
//

import UIKit

final class LoginCoordinator: BaseCoordinator {
    
    override func start() {
        let viewModel = LoginViewModelImpl()
        let viewController = LoginViewController(viewModel)
        navigationController.setViewControllers([viewController], animated: false)
    }
}
