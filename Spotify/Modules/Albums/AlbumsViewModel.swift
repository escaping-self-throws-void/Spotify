//
//  AlbumsViewModel.swift
//  Spotify
//
//  Created by Paul Matar on 04/12/2022.
//

import Combine

protocol AlbumsViewModel {
    var refresh: PassthroughSubject<Bool, Never> { get }
    var albums: [AlbumModel] { get }
    
    func getAlbums()
}

final class AlbumsViewModelImpl: AlbumsViewModel {
    private(set) var refresh = PassthroughSubject<Bool, Never>()
    private(set) var albums = [AlbumModel]()
    private let id: String
    private let service: ApiServiceProtocol
    
    init(service: ApiServiceProtocol, id: String) {
        self.service = service
        self.id = id
    }
    
    func getAlbums() {
        Task {
            do {
                let fetchedData = try await service.fetchAlbums(by: id)
                mapModels(fetchedData)
                refresh.send(true)
            } catch {
                debugPrint(error)
            }
        }
    }
    
    private func mapModels(_ data: [AlbumsItem]) {
        albums = data.map { AlbumModel(with: $0) }
    }
}
