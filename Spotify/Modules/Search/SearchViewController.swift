//
//  SearchViewController.swift
//  Spotify
//
//  Created by Paul Matar on 30/11/2022.
//

import UIKit

final class SearchViewController: UIViewController {
    
//    private let loginView = SearchView()
    
    private lazy var searchBar: UISearchBar = {
        let searchBar = UISearchBar()
        searchBar.placeholder = "Search for an artist..."
        searchBar.delegate = self
        return searchBar
    }()
    
    private let viewModel: SearchViewModel
    
    init(_ viewModel: SearchViewModel) {
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
//    override func loadView() {
//        view = loginView
//    }

    override func viewDidLoad() {
        super.viewDidLoad()
        initialize()
    }
    
    private func initialize() {
        view.backgroundColor = .red
        navigationItem.titleView = searchBar
    }
}

// MARK: - UISearchBarDelegate
extension SearchViewController: UISearchBarDelegate {
    func searchBar(_ searchBar: UISearchBar, textDidChange textSearched: String) {
        
    }
}
