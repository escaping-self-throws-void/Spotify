//
//  ApiService.swift
//  Spotify
//
//  Created by Paul Matar on 03/12/2022.
//

import Foundation

protocol ApiServiceProtocol {
    func fetchArtists(by name: String) async throws -> [ArtistsItem]
}

struct ApiService: HTTPClient, ApiServiceProtocol {
    func fetchArtists(by name: String) async throws -> [ArtistsItem] {
        guard let token = try await AuthManager.shared.withValidToken() else {
            throw RequestError.unknown
        }
        let endpoint = ApiEndpoint.artists(name: name, token: token)
        let data: DataContainer = try await sendRequest(endpoint: endpoint)
        
        let result = data.artists.items

        return result
    }
}
