//
//  UIImageView+Extensions.swift
//  Spotify
//
//  Created by Paul Matar on 03/12/2022.
//

import UIKit

extension UIImageView {
    @MainActor
    func loadFrom(url: String) {
        Task {
            do {
                let loadedImage = try await ImageLoader.shared.downloadImage(from: url)
                image = loadedImage
            } catch {
                debugPrint(error)
                image = .init(named: C.Images.placeholder)
            }
        }
    }
}
