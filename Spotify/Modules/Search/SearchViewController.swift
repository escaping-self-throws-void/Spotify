//
//  SearchViewController.swift
//  Spotify
//
//  Created by Paul Matar on 30/11/2022.
//

import UIKit
import Combine

final class SearchViewController: UIViewController {
    
    private let viewModel: SearchViewModel

    private let collectionView = SearchCollectionView()
    
    private lazy var dataSource = configureDataSource()

    private var cancellables = Set<AnyCancellable>()
    
    init(_ viewModel: SearchViewModel) {
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        initialize()
    }
    
    private func initialize() {
        dismissKeyboardOnTap()
        addSearchBar()
        collectionView.delegate = self
        collectionView.place(on: view).pin(
            .leading,
            .trailing,
            .bottom(to: view.safeAreaLayoutGuide, .bottom),
            .top(to: view.safeAreaLayoutGuide, .top)
        )
        setupViewModel()
    }
}

// MARK: - Private methods
extension SearchViewController {
    private func addSearchBar() {
        let searchBar = UISearchBar()
        searchBar.placeholder = C.Text.searchPlaceholder
        searchBar.delegate = self
        navigationItem.hidesBackButton = true
        navigationItem.titleView = searchBar
    }
    
    private func setupViewModel() {
        viewModel.refresh
            .receive(on: RunLoop.main)
            .sink { [weak self] _ in
                self?.createSnapshot()
            }
            .store(in: &cancellables)
    }
}

// MARK: - UISearchBarDelegate
extension SearchViewController: UISearchBarDelegate {
    func searchBar(_ searchBar: UISearchBar, textDidChange textSearched: String) {
        guard !textSearched.isEmpty else { return }
        viewModel.getArtists(by: textSearched)
    }
}

// MARK: - UICollectionViewDelegate
extension SearchViewController: UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {

    }
}

// MARK: - Diffable Data Source Setup
extension SearchViewController {
    
    fileprivate typealias SearchDataSource = UICollectionViewDiffableDataSource<Section, ArtistModel>
    fileprivate typealias SearchSnapshot = NSDiffableDataSourceSnapshot<Section, ArtistModel>

    fileprivate enum Section {
        case main
    }
    
    private func configureDataSource() -> SearchDataSource {
        let cellRegistration = UICollectionView.CellRegistration<SearchCell, ArtistModel> { cell, _, model in
            cell.configure(with: model)
        }
        
        return SearchDataSource(collectionView: collectionView) { collectionView, indexPath, itemIdentifier in
            collectionView.dequeueConfiguredReusableCell(using: cellRegistration, for: indexPath, item: itemIdentifier)
        }
    }
    
    private func createSnapshot() {
        var snapshot = SearchSnapshot()
        snapshot.appendSections([.main])
        snapshot.appendItems(viewModel.artists)
        
        dataSource.apply(snapshot)
    }
}
