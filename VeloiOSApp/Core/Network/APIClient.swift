//
//  APIClient.swift
//  VeloiOSApp
//
//  Created by Gabriel Araújo on 08/11/25.
//

import Foundation

enum APIError: Error {
    case badServerResponse
    case unauthorized
}

final class APIClient {
    private let tokenStore: TokenStore

    init(tokenStore: TokenStore = TokenStore()) {
        self.tokenStore = tokenStore
    }

    func request<T: Decodable>(_ endpoint: Endpoint, isRetry: Bool = false) async throws -> T {
        let (data, response) = try await URLSession.shared.data(for: endpoint.request)
        
        guard let httpResponse = response as? HTTPURLResponse else {
            throw APIError.badServerResponse
        }
        
        if httpResponse.statusCode == 401 && !isRetry {
            do {
                try await refreshToken()
                return try await request(endpoint, isRetry: true)
            } catch {
                DispatchQueue.main.async {
                    NotificationCenter.default.post(name: AppNotifications.userDidBecomeUnauthorized, object: nil)
                }
                throw APIError.unauthorized
            }
        }

        guard (200...299).contains(httpResponse.statusCode) else {
            throw APIError.badServerResponse
        }
        
        return try JSONDecoder().decode(T.self, from: data)
    }
    
    func requestNoResponse(_ endpoint: Endpoint, isRetry: Bool = false) async throws {
        let (_, response) = try await URLSession.shared.data(for: endpoint.request)
        
        guard let httpResponse = response as? HTTPURLResponse else {
            throw APIError.badServerResponse
        }

        if httpResponse.statusCode == 401 && !isRetry {
            do {
                try await refreshToken()
                try await requestNoResponse(endpoint, isRetry: true)
                return
            } catch {
                DispatchQueue.main.async {
                    NotificationCenter.default.post(name: AppNotifications.userDidBecomeUnauthorized, object: nil)
                }
                throw APIError.unauthorized
            }
        }

        guard (200...299).contains(httpResponse.statusCode) else {
            throw APIError.badServerResponse
        }
    }

    private func refreshToken() async throws {
        guard let token = tokenStore.getJwtToken().token else {
            throw APIError.unauthorized
        }

        let endpoint = UserEndpoint.refreshToken(token: token)
        let (data, response) = try await URLSession.shared.data(for: endpoint.request)

        guard let httpResponse = response as? HTTPURLResponse, (200...299).contains(httpResponse.statusCode) else {
            throw APIError.unauthorized
        }

        let refreshTokenResponse = try JSONDecoder().decode(RefreshTokenResponse.self, from: data)
        tokenStore.saveJwtToken(token: refreshTokenResponse.refreshToken)
    }
}
