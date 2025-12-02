//
//  User+APIClient.swift
//  VeloiOSApp
//
//  Created by Gabriel Araújo on 09/11/25.
//

import Foundation
import UIKit

final class UserAPIClient {
    private let client = APIClient()
    
    // MARK: - User
    func searchUser(by nickname: String) async throws -> FetchUserResponse {
        try await client.request(UserEndpoint.search(nickname: nickname))
    }
    
    // MARK: - Auth
    func login(email: String, password: String) async throws -> LoginKeyResponse {
        try await client.request(UserEndpoint.login(email: email, password: password))
    }
    
    func verify2FACode(key: String, code: String) async throws -> LoginTokenResponse {
        try await client.request(UserEndpoint.verificationCode(key: key, code: code))
    }
    
    func register(name: String, nickname: String, email: String, password: String) async throws -> RegisterResponse {
        try await client.request(UserEndpoint.register(name: name, nickname: nickname, email: email, password: password))
    }
    
    func refreshToken(token: String) async throws -> RefreshTokenResponse {
        try await client.request(UserEndpoint.refreshToken(token: token))
    }
    
    func forgotPassword(email: String) async throws -> StatusResponse {
        try await client.request(UserEndpoint.recoveryPassword(email: email))
    }

    func recoveryPasswordConfirmation(key: String, code: String, password: String) async throws -> StatusResponse {
        try await client.request(UserEndpoint.recoveryPasswordConfirmation(key: key, code: code, password: password))
    }
    
    // MARK: - Edit User Profile
    func editProfile(field: String, fieldValue: String) async throws -> StatusResponse {
        try await client.request(UserEndpoint.editProfile(field: field, fieldValue: fieldValue))
    }
    
    func editBanner(image: UIImage) async throws -> StatusResponse {
        try await client.request(UserEndpoint.editBanner(image: image))
    }
    
    func editPhoto(image: UIImage) async throws -> StatusResponse {
        try await client.request(UserEndpoint.editPhoto(image: image))
    }
    
    // MARK: - Admin
    func blockUser(nickname: String) async throws -> StatusResponse {
        try await client.request(UserEndpoint.blockUser(nickname: nickname))
    }
    
    func unblockUser(nickname: String) async throws -> StatusResponse {
        try await client.request(UserEndpoint.unblockUser(nickname: nickname))
    }
    
    func deleteUser(nickname: String) async throws -> StatusResponse {
        try await client.request(UserEndpoint.deleteUser(nickname: nickname))
    }
}
