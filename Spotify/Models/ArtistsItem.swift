//
//  ArtistsItem.swift
//  Spotify
//
//  Created by Paul Matar on 03/12/2022.
//

import Foundation

struct ArtistsContainer: Codable {
    let artists: Artists
}

struct Artists: Codable {
    let items: [ArtistsItem]
}

struct ArtistsItem: Codable {
    let followers: Followers
    let id: String
    let images: [Image]
    let name: String
    let popularity: Int

    enum CodingKeys: String, CodingKey {
        case followers, id, images, name, popularity
    }
}

struct Followers: Codable {
    let total: Int
}

struct Image: Codable {
    let url: String?
}
