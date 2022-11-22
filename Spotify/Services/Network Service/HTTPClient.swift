//
//  HTTPClient.swift
//  Spotify
//
//  Created by Paul Matar on 22/11/2022.
//

import UIKit

protocol HTTPClient {
    func sendRequest<T: Decodable>(endpoint: Endpoint) async throws -> T
}

extension HTTPClient {
    func sendRequest<T: Decodable>(endpoint: Endpoint) async throws -> T {
        guard let url = URL(string: endpoint.baseURL + endpoint.path) else {
            throw RequestError.invalidURL
        }

        var request = URLRequest(url: url)
        request.httpMethod = endpoint.method.rawValue
        request.allHTTPHeaderFields = endpoint.header
        request.addValue("application/json", forHTTPHeaderField: "Content-Type")

        if let body = endpoint.body {
            request.httpBody = try? JSONSerialization.data(withJSONObject: body, options: [])
        }
        
        let (data, response) = try await URLSession.shared.data(for: request)
        
        guard let response = response as? HTTPURLResponse else {
            throw RequestError.invalidResponse
        }
        
        guard (200..<300) ~= response.statusCode else {
            throw RequestError.invalidStatusCode(response.statusCode)
        }
        
        guard let decodedResponse = try? JSONDecoder().decode(T.self, from: data) else {
            throw RequestError.unableToDecode
        }
        
        return decodedResponse
    }
}
