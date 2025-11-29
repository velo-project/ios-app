//
//  UserProfileService.swift
//  VeloiOSApp
//
//  Created by Gabriel Araújo Lima on 26/11/25.
//

import Foundation

actor UserProfileService {
    private let apiClient: UserAPIClient
    
    init(apiClient: UserAPIClient = UserAPIClient()) {
        self.apiClient = apiClient
    }
    
    func fetchUser(nickname: String) async throws -> User {
        try await apiClient.searchUser(by: nickname)
    }
    
    func uploadProfilePhoto(imageData: Data) async throws {
        _ = try await apiClient.editPhoto(imageData: imageData)
    }
    
    func uploadBanner(imageData: Data) async throws {
        _ = try await apiClient.editBanner(imageData: imageData)
    }
}
