//
//  SearchViewController.swift
//  Spotify
//
//  Created by Paul Matar on 30/11/2022.
//

import UIKit

final class SearchViewController: UIViewController {
    
//    private let loginView = SearchView()
    
    private let viewModel: SearchViewModel
    
    init(_ viewModel: SearchViewModel) {
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)
        initialize()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
//    override func loadView() {
//        view = loginView
//    }

    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    private func initialize() {
        
    }
}
