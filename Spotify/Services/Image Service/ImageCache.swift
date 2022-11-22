//
//  ImageCache.swift
//  Spotify
//
//  Created by Paul Matar on 22/11/2022.
//

import UIKit

final class ImageCache {
     
    static let shared = ImageCache()
    
    private var cache = NSCache<NSString, UIImage>()
    
    private init() {}
    
    func getImage(forKey key: String) -> UIImage? {
        cache.object(forKey: key as NSString)
    }
    
    func saveImage(_ image: UIImage, forKey key: String) {
        cache.setObject(image, forKey: key as NSString)
    }
}
