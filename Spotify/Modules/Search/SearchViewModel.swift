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
    func goToDetails(_ data: Any)
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
                try await Task.sleep(nanoseconds: 500_000_000)
                let fetchedData = try await service.fetchArtists(by: name)
                mapModels(fetchedData)
                refresh.send(true)
            } catch {
                debugPrint(error)
            }
        }
    }
    
    func goToDetails(_ data: Any) {
    }
    
    private func mapModels(_ data: [ArtistsItem]) {
        artists = data.map { ArtistModel(with: $0) }
    }
}
