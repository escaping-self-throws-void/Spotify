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

        if let body = endpoint.body {
            request.httpBody = try? JSONSerialization.data(withJSONObject: body, options: [])
        }
        
        if let query = endpoint.query {
            var components = URLComponents()
            components.queryItems = query
                .compactMap { URLQueryItem(name: $0.key, value: $0.value) }
            request.httpBody = components.query?.data(using: .utf8)
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

extension Data {
    var prettyPrintedJSONString: NSString? {
        guard let object = try? JSONSerialization.jsonObject(with: self, options: []),
              let data = try? JSONSerialization.data(withJSONObject: object, options: [.prettyPrinted]),
              let prettyPrintedString = NSString(data: data, encoding: String.Encoding.utf8.rawValue) else { return nil }
        return prettyPrintedString
    }
}
