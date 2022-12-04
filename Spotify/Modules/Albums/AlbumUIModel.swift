//
//  AlbumUIModel.swift
//  Spotify
//
//  Created by Paul Matar on 04/12/2022.
//

import Foundation

struct AlbumModel: Hashable {
    let id: String
    let artists: String
    let image: String
    let name: String
    let releaseYear: String
    let totalTracks: String
    let externalLink: String
    
    func hash(into hasher: inout Hasher) {
        hasher.combine(id)
    }
    
    static func == (lhs: AlbumModel, rhs: AlbumModel) -> Bool {
        lhs.id == rhs.id
    }
    
    init(with model: AlbumsItem) {
        id = model.id
        artists = model.artists.map { $0.name }.joined(separator: ", ")
        image = model.images.first?.url ?? ""
        name = model.name
        releaseYear = "\(model.releaseDate.prefix(4)) year"
        totalTracks = "\(model.totalTracks) tracks"
        externalLink = model.externalUrls.spotify ?? ""
    }
}
