//
//  AuthViewController.swift
//  Spotify
//
//  Created by Paul Matar on 29/11/2022.
//

import UIKit
import WebKit

final class AuthViewController: UIViewController, WKNavigationDelegate {
    
    private let webView: WKWebView = {
        let prefs = WKWebpagePreferences()
        prefs.allowsContentJavaScript = true
        let config = WKWebViewConfiguration()
        let webView = WKWebView(frame: .zero, configuration: config)
        return webView
    }()
    
    var completionHandler: ((Bool) -> Void)?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        title = "SIGN IN"
        view.backgroundColor = .red
        view.addSubview(webView)
        webView.navigationDelegate = self
        guard let url = AuthManager.shared.signInURL else { return }
        webView.load(.init(url: url))
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        webView.frame = view.bounds
    }
    
    func webView(_ webView: WKWebView, didStartProvisionalNavigation navigation: WKNavigation!) {
        guard let url = webView.url else { return }
        
        let component = URLComponents(string: url.absoluteString)
        guard let code = component?.queryItems?
            .first(where: { $0.name == "code" })?.value else { return }
        webView.isHidden = true
        
        print("Code: \(code)")
        AuthManager.shared.exchangeCodeForToken(code: code) { [weak self] success in
            DispatchQueue.main.async {
                self?.dismiss(animated: true)
                self?.completionHandler!(success)
            }
        }
    }
}
