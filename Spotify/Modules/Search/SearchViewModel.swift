//
//  SearchViewModel.swift
//  Spotify
//
//  Created by Paul Matar on 30/11/2022.
//

import Combine

protocol SearchViewModel {
    var refresh: PassthroughSubject<Bool, Never> { get }
    var artists: [ArtistModel] { get }
    
    func getArtists(by name: String)
}

final class SearchViewModelImpl: SearchViewModel {
    private(set) var refresh = PassthroughSubject<Bool, Never>()
    private(set) var artists = [ArtistModel]()
    
    private let service: ApiServiceProtocol
    
    init(service: ApiServiceProtocol) {
        self.service = service
    }
    
    func getArtists(by name: String) {
        Task {
            do {
                try await Task.sleep(nanoseconds: 300_000_000)
                let fetchedData = try await service.fetchArtists(by: name.trimmed)
                mapModels(fetchedData)
                refresh.send(true)
            } catch {
                debugPrint(error)
            }
        }
    }
    
    private func mapModels(_ data: [ArtistsItem]) {
        artists = data.map { ArtistModel(with: $0) }
    }
}
