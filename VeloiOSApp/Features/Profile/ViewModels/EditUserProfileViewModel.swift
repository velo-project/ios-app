//
//  EditUserProfileViewModel.swift
//  VeloiOSApp
//
//  Created by Gabriel Araújo Lima on 01/12/25.
//

import SwiftUI
import Foundation
import Sentry

@MainActor
class EditUserProfileViewModel: ObservableObject {
    @Published var user: User?
    @Published var isLoading = false
    @Published var name: String = ""
    @Published var nickname: String = ""
    @Published var description: String = ""
    @Published var showErrorAlert = false
    @Published var errorMessage = ""
    @Published var showSuccessAlert = false
    @Published var successMessage = ""

    private var userProfileService = UserProfileService()

    init(user: User) {
        self.user = user
        self.name = user.name
        self.nickname = user.nickname
        self.description = user.description ?? ""
    }

    func uploadProfilePhoto(image: UIImage) async {
        isLoading = true
        do {
            try await userProfileService.uploadProfilePhoto(image: image)
            // Should we refresh the user data here?
        } catch {
            print(error)
            errorMessage = error.localizedDescription
            showErrorAlert = true
            SentrySDK.capture(error: error)
        }
        isLoading = false
    }

    func uploadBanner(image: UIImage) async {
        isLoading = true
        do {
            try await userProfileService.uploadBanner(image: image)
            // Should we refresh the user data here?
        } catch {
            errorMessage = "Erro ao enviar o banner. Tente novamente."
            showErrorAlert = true
            SentrySDK.capture(error: error)
        }
        isLoading = false
    }

    func saveProfile() async {
        isLoading = true
        do {
            if name != user?.name {
                try await userProfileService.editProfile(field: "NAME", fieldValue: name)
            }
            if nickname != user?.nickname {
                try await userProfileService.editProfile(field: "NICKNAME", fieldValue: nickname)
            }
            if description != user?.description {
                try await userProfileService.editProfile(field: "DESCRIPTION", fieldValue: description)
            }
            successMessage = "Perfil salvo com sucesso!"
            showSuccessAlert = true
        } catch {
            errorMessage = "Erro ao salvar o perfil. Tente novamente."
            showErrorAlert = true
            SentrySDK.capture(error: error)
        }
        isLoading = false
    }
}
