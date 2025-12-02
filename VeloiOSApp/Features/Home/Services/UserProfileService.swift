//
//  UserProfileService.swift
//  VeloiOSApp
//
//  Created by Gabriel Araújo Lima on 26/11/25.
//

import Foundation
import UIKit

actor UserProfileService {
    private let apiClient: UserAPIClient
    
    init(apiClient: UserAPIClient = UserAPIClient()) {
        self.apiClient = apiClient
    }
    
    func fetchUser(nickname: String) async throws -> FetchUserResponse {
        try await apiClient.searchUser(by: nickname)
    }
    
    func uploadProfilePhoto(image: UIImage) async throws {
        _ = try await apiClient.editPhoto(image: image)
    }
    
    func uploadBanner(image: UIImage) async throws {
        _ = try await apiClient.editBanner(image: image)
    }

    func editProfile(field: String, fieldValue: String) async throws {
        _ = try await apiClient.editProfile(field: field, fieldValue: fieldValue)
    }
}
