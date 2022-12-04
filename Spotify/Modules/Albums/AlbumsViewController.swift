//
//  AlbumsViewController.swift
//  Spotify
//
//  Created by Paul Matar on 04/12/2022.
//

import UIKit
import Combine

final class AlbumsViewController: UIViewController {
    
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
        setupNavigationBar()
        collectionView.delegate = self
        bindViewModel()
    }
}

// MARK: - Private methods
extension AlbumsViewController {
    private func setupNavigationBar() {

    }
    
    private func layoutViews() {
        collectionView.place(on: view).pin(
            .leading,
            .trailing,
            .bottom(to: view.safeAreaLayoutGuide, .bottom),
            .top(to: view.safeAreaLayoutGuide, .top)
        )
    }
    
    private func bindViewModel() {
        viewModel.refresh
            .receive(on: RunLoop.main)
            .sink { [weak self] _ in
                self?.createSnapshot()
            }
            .store(in: &cancellables)
    }
}

// MARK: - UICollectionViewDelegate
extension AlbumsViewController: UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {

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
        let cellRegistration = UICollectionView.CellRegistration<AlbumCell, AlbumModel> { cell, _, model in
            cell.configure(with: model)
        }
        
        return AlbumsDataSource(collectionView: collectionView) { collectionView, indexPath, itemIdentifier in
            collectionView.dequeueConfiguredReusableCell(using: cellRegistration, for: indexPath, item: itemIdentifier)
        }
    }
    
    private func createSnapshot() {
        var snapshot = AlbumsSnapshot()
        snapshot.appendSections([.main])
        snapshot.appendItems(viewModel.albums)
        
        dataSource.apply(snapshot)
    }
}

