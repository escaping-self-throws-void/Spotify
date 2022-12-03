//
//  ApiEndpoint.swift
//  Spotify
//
//  Created by Paul Matar on 03/12/2022.
//

import Foundation

enum ApiEndpoint {
    case artists(name: String, token: String)
    case albums(id: String, token: String)
}

extension ApiEndpoint: Endpoint {
    var path: String {
        switch self {
        case .artists(let name, _):
            return "/search?q=artist=\(name)&type=artist"
        case .albums(let id, _):
            return "/artists/\(id)/albums"
        }
    }
    
    var method: RequestMethod {
        switch self {
        case .artists, .albums:
            return .GET
        }
    }
    
    var header: [String : String]? {
        let accessToken: String
        switch self {
        case .artists(_, let token), .albums(_, let token):
            accessToken = token
        }
        return ["Authorization": "Bearer \(accessToken)"]
    }

}
