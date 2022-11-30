//
//  ViewController.swift
//  Spotify
//
//  Created by Paul Matar on 22/11/2022.
//

import UIKit

final class LoginViewController: UIViewController {
    
    private let loginView = LoginView()
    
    override func loadView() {
        view = loginView
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        initialize()
    }
    
    private func initialize() {
        loginView.onButtonClick = loginPressed
    }
}

// MARK: - Actions
extension LoginViewController {
    private func loginPressed() {
        guard let url = AuthManager.shared.signInURL else { return }
        
        let vc = WebViewController(url: url, completionHandler: handleCompletion)
        present(vc, animated: true)
    }
}

// MARK: - Private methods
extension LoginViewController {
    private func handleCompletion() {
        let vm = SearchViewModelImpl()
        let vc = SearchViewController(vm)
        navigationController?.pushViewController(vc, animated: false)
    }
}
