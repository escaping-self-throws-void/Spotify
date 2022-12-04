//
//  SearchViewController.swift
//  Spotify
//
//  Created by Paul Matar on 30/11/2022.
//

import UIKit
import Combine

final class SearchViewController: BaseViewController {
    
    private let viewModel: SearchViewModel
    
    private let collectionView = SpotifyCollectionView()
    
    private let welcomeView = WelcomeView()
    
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
    
    override func viewWillLayoutSubviews() {
        super.viewWillLayoutSubviews()
        layoutViews()
    }
    
    private func initialize() {
        setupNavigationBar()
        collectionView.delegate = self
        bindViewModel()
    }
    
    private func layoutViews() {
        welcomeView.place(on: view).pin(
            .centerX,
            .centerY
        )
        collectionView.place(on: view).pin(
            .leading,
            .trailing,
            .bottom(to: view.safeAreaLayoutGuide, .bottom),
            .top(to: view.safeAreaLayoutGuide, .top)
        )
    }
}

// MARK: - Private methods
extension SearchViewController {
    private func setupNavigationBar() {
        let searchBar = UISearchBar()
        searchBar.placeholder = C.Text.searchPlaceholder
        searchBar.delegate = self
        navigationItem.hidesBackButton = true
        navigationItem.titleView = searchBar
    }
    
    private func bindViewModel() {
        viewModel.refresh
            .receive(on: RunLoop.main)
            .sink { [weak self] _ in
                self?.welcomeView.isHidden = true
                self?.createSnapshot()
            }
            .store(in: &cancellables)
    }
}

// MARK: - Actions
extension SearchViewController {
    private func openAlbumsScreen(_ id: String, title: String) {
        let vm = AlbumsViewModelImpl(service: ApiService(), id: id)
        let vc = AlbumsViewController(vm)
        vc.title = title
        navigationController?.pushViewController(vc, animated: true)
    }
}

// MARK: - UISearchBarDelegate
extension SearchViewController: UISearchBarDelegate {
    func searchBar(_ searchBar: UISearchBar, textDidChange textSearched: String) {
        guard !textSearched.isEmpty else { return }
        viewModel.getArtists(by: textSearched)
    }
    
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        searchBar.text = ""
        searchBar.resignFirstResponder()
    }
}

// MARK: - UICollectionViewDelegate
extension SearchViewController: UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        collectionView.deselectItem(at: indexPath, animated: false)
        guard let artist = dataSource.itemIdentifier(for: indexPath) else { return }
        openAlbumsScreen(artist.id, title: artist.name)
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
        snapshot.appendItems(viewModel.artists, toSection: .main)
        dataSource.apply(snapshot)
    }
}
