//
//  LoginViewModel.swift
//  Spotify
//
//  Created by Paul Matar on 22/11/2022.
//

import Foundation
 
protocol LoginViewModel {
    func loginWithSpotify()
}

final class LoginViewModelImpl: LoginViewModel {
    func loginWithSpotify() {
        print("login")
    }
}
