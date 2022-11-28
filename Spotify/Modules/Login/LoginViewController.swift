//
//  ViewController.swift
//  Spotify
//
//  Created by Paul Matar on 22/11/2022.
//

import UIKit

final class LoginViewController: UIViewController {
    
    private let loginView = LoginView()
    
    private let viewModel: LoginViewModel
    
    init(_ viewModel: LoginViewModel) {
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)
        initialize()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func loadView() {
        view = loginView
    }

    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    private func initialize() {
        loginView.onButtonClick = loginPressed
    }

}

// MARK: - Actions

extension LoginViewController {

    private func loginPressed() {
        viewModel.loginWithSpotify()
    }
}
