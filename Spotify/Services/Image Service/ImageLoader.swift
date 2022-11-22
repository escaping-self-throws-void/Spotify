//
//  ImageLoader.swift
//  Spotify
//
//  Created by Paul Matar on 22/11/2022.
//

import UIKit

actor ImageLoader {
    
    static let shared = ImageLoader()
    
    private let imageCache = ImageCache.shared
    
    private init() {}

    func downloadImage(from link: String) async throws -> UIImage {
        if let cachedImage = imageCache.getImage(forKey: link) {
            return cachedImage
        }
        
        guard let url = URL(string: link) else {
            throw RequestError.invalidURL
        }
        
        let (data, response) = try await URLSession.shared.data(from: url)
        
        guard let response = response as? HTTPURLResponse else {
            throw RequestError.invalidResponse
        }

        guard (200..<300) ~= response.statusCode else {
            throw RequestError.invalidStatusCode(response.statusCode)
        }
        

        guard let image = UIImage(data: data) else {
            throw RequestError.unknown
        }

        imageCache.saveImage(image, forKey: link)
        
        return image
    }
}
