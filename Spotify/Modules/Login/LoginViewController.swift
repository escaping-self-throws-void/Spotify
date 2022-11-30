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
        guard let url = AuthManager.shared.signInURL else { return }
        let vc = AuthViewController(url: url) { [weak self] success in
            DispatchQueue.main.async {
                self?.handleSignIn(success: success)
            }
        }
        present(vc, animated: true)
    }
}

extension LoginViewController {
    private func handleSignIn(success: Bool) {
        guard success else {
            return
        }
    }
}
