//
//  APIClient.swift
//  VeloiOSApp
//
//  Created by Gabriel Araújo on 08/11/25.
//

import Foundation
import SwiftUI
import Alamofire

enum APIError: Error {
    case badServerResponse
    case unauthorized
}

final class APIClient {
    @ObservedObject private var tokenStore: TokenStore

    init(tokenStore: TokenStore = TokenStore.shared) {
        self.tokenStore = tokenStore
    }

    func request<T: Decodable>(_ endpoint: Endpoint, isRetry: Bool = false) async throws -> T {
        // Handle image upload with Alamofire
        if case let userEndpoint as UserEndpoint = endpoint, let image = userEndpoint.getImage() {
            guard let imageData = image.jpegData(compressionQuality: 0.8) else {
                throw APIError.badServerResponse
            }
            
            let url = userEndpoint.baseUrl.appendingPathComponent(userEndpoint.path)
            let headers: HTTPHeaders = [
                "Authorization": "Bearer \(tokenStore.getJwtToken().token ?? "")",
                "Accept": "application/json"
            ]
            
            let uploadRequest = AF.upload(multipartFormData: { multipartFormData in
                multipartFormData.append(imageData, withName: "image", fileName: "image.jpg", mimeType: "image/jpeg")
            }, to: url, method: .put, headers: headers)
            
            let response = await uploadRequest.serializingData().response
            
            if let error = response.error {
                // Handle 401 Unauthorized for Alamofire
                if response.response?.statusCode == 401 && !isRetry {
                    do {
                        try await refreshToken()
                        return try await request(endpoint, isRetry: true) // Retry with new token
                    } catch {
                        DispatchQueue.main.async {
                            NotificationCenter.default.post(name: AppNotifications.userDidBecomeUnauthorized, object: nil)
                        }
                        throw APIError.unauthorized
                    }
                }
                throw error
            }
            
            guard let httpResponse = response.response else {
                throw APIError.badServerResponse
            }
            
            guard (200...299).contains(httpResponse.statusCode) else {
                throw APIError.badServerResponse
            }
            
            guard let data = response.data else {
                throw APIError.badServerResponse
            }
            
            return try JSONDecoder().decode(T.self, from: data)
            
        } else { // Existing URLSession logic for non-image uploads
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
    }
    
    func requestNoResponse(_ endpoint: Endpoint, isRetry: Bool = false) async throws {
        // Handle image upload with Alamofire
        if case let userEndpoint as UserEndpoint = endpoint, let image = userEndpoint.getImage() {
            guard let imageData = image.jpegData(compressionQuality: 0.8) else {
                throw APIError.badServerResponse
            }
            
            let url = userEndpoint.baseUrl.appendingPathComponent(userEndpoint.path)
            let headers: HTTPHeaders = [
                "Authorization": "Bearer \(tokenStore.getJwtToken().token ?? "")",
                "Accept": "application/json"
            ]
            
            let uploadRequest = AF.upload(multipartFormData: { multipartFormData in
                multipartFormData.append(imageData, withName: "image", fileName: "image.jpg", mimeType: "image/jpeg")
            }, to: url, method: .put, headers: headers)
            
            let response = await uploadRequest.serializingData().response
            
            if let error = response.error {
                // Handle 401 Unauthorized for Alamofire
                if response.response?.statusCode == 401 && !isRetry {
                    do {
                        try await refreshToken()
                        try await requestNoResponse(endpoint, isRetry: true) // Retry with new token
                        return
                    } catch {
                        DispatchQueue.main.async {
                            NotificationCenter.default.post(name: AppNotifications.userDidBecomeUnauthorized, object: nil)
                        }
                        throw APIError.unauthorized
                    }
                }
                throw error
            }
            
            guard let httpResponse = response.response else {
                throw APIError.badServerResponse
            }
            
            guard (200...299).contains(httpResponse.statusCode) else {
                throw APIError.badServerResponse
            }
            
            return
            
        } else { // Existing URLSession logic for non-image uploads
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
