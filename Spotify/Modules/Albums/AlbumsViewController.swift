//
//  AlbumsViewController.swift
//  Spotify
//
//  Created by Paul Matar on 04/12/2022.
//

import UIKit
import Combine

final class AlbumsViewController: BaseViewController {
    
    private let viewModel: AlbumsViewModel

    private let collectionView = SpotifyCollectionView()
    
    private lazy var dataSource = configureDataSource()

    private var cancellables = Set<AnyCancellable>()
    
    init(_ viewModel: AlbumsViewModel) {
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
        navigationController?.navigationBar.tintColor = .white
        bindViewModel()
        viewModel.getAlbums()
    }
    
    private func layoutViews() {
        collectionView.place(on: view).pin(
            .leading,
            .trailing,
            .bottom(to: view.safeAreaLayoutGuide, .bottom),
            .top(to: view.safeAreaLayoutGuide, .top)
        )
    }
}

// MARK: - Private methods
extension AlbumsViewController {
    private func bindViewModel() {
        viewModel.refresh
            .receive(on: RunLoop.main)
            .sink { [weak self] _ in
                self?.createSnapshot()
            }
            .store(in: &cancellables)
    }
}

// MARK: - Actions {
extension AlbumsViewController {
    private func openExternalUrl(_ stringUrl: String) {
        guard let url = URL(string: stringUrl) else { return }
        let vc = WebViewController(url: url)
        present(vc, animated: true)
    }
}

// MARK: - Diffable Data Source Setup
extension AlbumsViewController {
    
    fileprivate typealias AlbumsDataSource = UICollectionViewDiffableDataSource<Section, AlbumModel>
    fileprivate typealias AlbumsSnapshot = NSDiffableDataSourceSnapshot<Section, AlbumModel>

    fileprivate enum Section {
        case main
    }
    
    private func configureDataSource() -> AlbumsDataSource {
        let cellRegistration = UICollectionView.CellRegistration<AlbumCell, AlbumModel> { [weak self] cell, _, model in
            cell.configure(with: model)
            cell.onButtonClick = self?.openExternalUrl(_:)
        }
        
        return AlbumsDataSource(collectionView: collectionView) { collectionView, indexPath, itemIdentifier in
            collectionView.dequeueConfiguredReusableCell(using: cellRegistration, for: indexPath, item: itemIdentifier)
        }
    }
    
    private func createSnapshot() {
        var snapshot = AlbumsSnapshot()
        snapshot.appendSections([.main])
        snapshot.appendItems(viewModel.albums, toSection: .main)
        dataSource.apply(snapshot)
    }
}
