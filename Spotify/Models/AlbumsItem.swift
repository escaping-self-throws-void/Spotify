//
//  AlbumsItem.swift
//  Spotify
//
//  Created by Paul Matar on 04/12/2022.
//

import Foundation

struct AlbumsContainer: Codable {
    let items: [AlbumsItem]
}

struct AlbumsItem: Codable {
    let artists: [Artist]
    let externalUrls: ExternalUrls
    let id: String
    let images: [Image]
    let name, releaseDate: String
    let totalTracks: Int

    enum CodingKeys: String, CodingKey {
        case artists
        case externalUrls = "external_urls"
        case id, images, name
        case releaseDate = "release_date"
        case totalTracks = "total_tracks"
    }
}

struct ExternalUrls: Codable {
    let spotify: String?
}

struct Artist: Codable {
    let name: String
}
