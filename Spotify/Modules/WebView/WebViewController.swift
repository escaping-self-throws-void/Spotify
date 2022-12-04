//
//  WebViewController.swift
//  Spotify
//
//  Created by Paul Matar on 29/11/2022.
//

import UIKit
import WebKit

final class WebViewController: BaseViewController {
    
    private lazy var webView: WKWebView = {
        let prefs = WKWebpagePreferences()
        prefs.allowsContentJavaScript = true
        let config = WKWebViewConfiguration()
        let webView = WKWebView(frame: .zero, configuration: config)
        webView.navigationDelegate = self
        webView.allowsBackForwardNavigationGestures = true
        return webView
    }()
    
    private let completionHandler: VoidClosure?
    private let url: URL
    
    init(url: URL, completionHandler: VoidClosure? = nil) {
        self.completionHandler = completionHandler
        self.url = url
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func loadView() {
        view = webView
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        webView.load(.init(url: url))
    }
}

// MARK: - WKNavigationDelegate
extension WebViewController: WKNavigationDelegate {
    func webView(_ webView: WKWebView, didStartProvisionalNavigation navigation: WKNavigation!) {
        guard url == AuthManager.shared.signInURL else { return }
        checkForCode(webView.url) { [weak self] success in
            guard success else { return }
            DispatchQueue.main.async {
                self?.dismiss(animated: true)
                self?.completionHandler?()
            }
        }
    }
}

// MARK: - Private methods
extension WebViewController {
    private func checkForCode(_ url: URL?, completion: @escaping BoolClosure) {
        guard let url else { return }
        
        let component = URLComponents(string: url.absoluteString)
        guard let code = component?.queryItems?
            .first(where: { $0.name == "code" })?.value else { return }
        
        AuthManager.shared.exchangeCodeForToken(code: code, completion: completion)
    }
}
