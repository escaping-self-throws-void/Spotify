//
//  SearchUIModel.swift
//  Spotify
//
//  Created by Paul Matar on 03/12/2022.
//

import UIKit

struct ArtistModel: Hashable {
    let id: String
    let followers: String
    let image: String
    let name: String
    let rating: Float
    
    func hash(into hasher: inout Hasher) {
        hasher.combine(id)
    }
    
    static func == (lhs: ArtistModel, rhs: ArtistModel) -> Bool {
        lhs.id == rhs.id
    }
    
    init(with model: ArtistsItem) {
        id = model.id
        followers = "\(model.followers.total) followers"
        image = model.images.first?.url ?? ""
        name = model.name
        rating = Float(model.popularity) / 10
    }
}
