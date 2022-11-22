//
//  Endpoint.swift
//  Spotify
//
//  Created by Paul Matar on 22/11/2022.
//

import Foundation

protocol Endpoint {
    var baseURL: String { get }
    var path: String { get }
    var method: RequestMethod { get }
    var header: [String: String]? { get }
    var body: [String: Any]? { get }
}

extension Endpoint {
    var baseURL: String {
        "https://\(Bundle.main.infoDictionary?["BASE_URL"] ?? "")"
    }
}

enum RequestMethod: String {
    case DELETE
    case GET
    case PATCH
    case POST
    case PUT
}

