//
//  AuthEndpoint.swift
//  Spotify
//
//  Created by Paul Matar on 03/12/2022.
//

import Foundation

enum AuthEndpoint {
    case exchange(code: String)
    case refresh(token: String)
    case authorize
}

extension AuthEndpoint: Endpoint {
    var baseURL: String {
        "https://\(Bundle.main.infoDictionary?["AUTH_URL"] ?? "")"
    }
    
    var path: String {
        switch self {
        case .exchange, .refresh:
            return "/api/token"
        case .authorize:
            return "/authorize?response_type=code&client_id=\(clientID)&scope=\(scopes)&redirect_uri=\(baseURL)&show_dialog=TRUE"
        }
    }
    
    var method: RequestMethod {
        switch self {
        case .exchange, .refresh:
            return .POST
        default:
            return .GET
        }
    }
    
    var header: [String : String]? {
        let basicToken = clientID + ":" + clientSecret
        return [
            "Content-Type": "application/x-www-form-urlencoded",
            "Authorization": "Basic \(basicToken.base64)"
        ]
    }
    
    var query: [String : String]? {
        switch self {
        case .exchange(code: let code):
            return ["grant_type": "authorization_code",
                    "code": code, "redirect_uri": baseURL]
        case .refresh(token: let token):
            return ["grant_type": "refresh_token",
                    "refresh_token": token]
        default:
            return nil
        }
    }
    
    private var clientID: String {
        Bundle.main.infoDictionary?["CLIENT_ID"] as? String ?? ""
    }
    
    private var clientSecret: String {
        Bundle.main.infoDictionary?["CLIENT_SECRET"] as? String ?? ""
    }
    
    private var scopes: String {
        "user-read-private%20user-library-read"
    }
}
