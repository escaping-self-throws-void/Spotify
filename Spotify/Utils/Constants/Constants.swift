//
//  Constants.swift
//  Spotify
//
//  Created by Paul Matar on 22/11/2022.
//

import Foundation

enum C {
    enum Images {
        static let spotify = "spotifyIcon"
        static let fullStar = "star.fill"
        static let halfStar = "star.lefthalf.fill"
        static let emptyStar = "star"
        static let placeholder = "placeholder"
    }
    
    enum Text {
        static let millionsOfSongs = "Millions of songs.\n Free on Spotify."
        static let login = "Login with Spotify"
        static let searchPlaceholder = "Search for an artist..."
        static let preview = "Preview on Spotify"
        static let find = "Find your favorites"
        static let search = "Search for any artist you follow."
    }
    
    enum Memory {
        static let accessToken = "accessToken"
        static let refreshToken = "refreshToken"
        static let expirationDate = "expirationDate"
    }
}
