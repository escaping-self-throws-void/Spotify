//
//  AuthManager.swift
//  Spotify
//
//  Created by Paul Matar on 30/11/2022.
//

import Foundation

final class AuthManager {
    
    static let shared = AuthManager()
    
    var signInURL: URL? {
        let enpoint = AuthEndpoint.authorize
        let basePath = enpoint.baseURL + enpoint.path
        return URL(string: basePath)
    }
    
    var isSignedIn: Bool {
        accessToken != nil
    }
    
    private var accessToken: String? {
        UserDefaults.standard.string(forKey: C.Memory.accessToken)
    }
    
    private var refreshToken: String? {
        UserDefaults.standard.string(forKey: C.Memory.refreshToken)
    }
    
    private var tokenExpirationDate: Date? {
        UserDefaults.standard.object(forKey: C.Memory.expirationDate) as? Date
    }
    
    private var shouldRefreshToken: Bool {
        if let tokenExpirationDate {
            return Date().addingTimeInterval(300) >= tokenExpirationDate
        }
        return false
    }
    
    private init() {}
}

// MARK: - Public methods
extension AuthManager {
    
    public func withValidToken() async throws -> String? {
        if shouldRefreshToken, let refreshToken {
            return try await refreshIfNeeded(refreshToken).accessToken
        } else if let accessToken {
            return accessToken
        }
        return nil
    }
    
    public func exchangeCodeForToken(code: String, completion: @escaping BoolClosure) {
        Task {
            do {
                _ = try await exchangeCode(code)
                completion(true)
            } catch {
                debugPrint(error.localizedDescription)
                completion(false)
            }
        }
    }
    
    public func refreshAccessToken(completion: @escaping BoolClosure) {
        guard shouldRefreshToken, refreshToken != nil else {
            return
        }
        guard let token = refreshToken else { return }
        
        Task {
            do {
                _ = try await refreshIfNeeded(token)
                completion(true)
            } catch {
                debugPrint(error.localizedDescription)
                completion(false)
            }
        }
    }
}

// MARK: - Private methods
extension AuthManager {
    private func cacheToken(result: AuthResponse) {
        UserDefaults.standard.setValue(result.accessToken, forKey: C.Memory.accessToken)
        if let refreshToken = result.refreshToken {
            UserDefaults.standard.setValue(refreshToken, forKey: C.Memory.refreshToken)
        }
        let expirationDate = Date().addingTimeInterval(.init(result.expiresIn))
        UserDefaults.standard.setValue(expirationDate, forKey: C.Memory.expirationDate)
    }
}

// MARK: - API Call methods
extension AuthManager: HTTPClient {
    private func exchangeCode(_ code: String) async throws -> AuthResponse {
        let response: AuthResponse = try await sendRequest(endpoint: AuthEndpoint.exchange(code: code))
        cacheToken(result: response)
        return response
    }
    
    private func refreshIfNeeded(_ token: String) async throws -> AuthResponse {
        let response: AuthResponse = try await sendRequest(endpoint: AuthEndpoint.refresh(token: token))
        cacheToken(result: response)
        return response
    }
}

