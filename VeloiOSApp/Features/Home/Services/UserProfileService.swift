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
    private let nicknameStore: NicknameStore

    init(apiClient: UserAPIClient = UserAPIClient(), nicknameStore: NicknameStore = NicknameStore.shared) {
        self.apiClient = apiClient
        self.nicknameStore = nicknameStore
    }

    func fetchUser(nickname: String? = nil) async throws -> FetchUserResponse {
        let userNickname = nickname ?? nicknameStore.getNickname() ?? ""
        return try await apiClient.searchUser(by: userNickname)
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
