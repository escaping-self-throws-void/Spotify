//
//  String+Extensions.swift
//  Spotify
//
//  Created by Paul Matar on 03/12/2022.
//

import Foundation

extension String {
    var base64: String {
        data(using: .utf8)?.base64EncodedString() ?? ""
    }
}
