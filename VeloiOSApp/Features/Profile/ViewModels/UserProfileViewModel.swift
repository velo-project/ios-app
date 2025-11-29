//
//  UserProfileViewModel.swift
//  VeloiOSApp
//
//  Created by Gabriel Araújo Lima on 26/11/25.
//

import SwiftUI
import Foundation

@MainActor
class UserProfileViewModel: ObservableObject {
    @Published var user: User?
    @Published var isLoading = false
    
    private var userProfileService = UserProfileService()
    private var authService = AuthService()
    
    @ObservedObject private var tokenStore = TokenStore.shared
    @ObservedObject private var tabStore = TabStore.shared
    
    // Hardcoded for now, should be dynamically retrieved
    private let nickname = "dotrujos_" 
    
    func fetchUser() async {
        isLoading = true
        do {
            let response = try await userProfileService.fetchUser(nickname: nickname)
            user = response.user
        } catch {
            print("Error fetching user: \(error)")
        }
        isLoading = false
    }
    
    func uploadProfilePhoto(imageData: Data) async {
        isLoading = true
        do {
            try await userProfileService.uploadProfilePhoto(imageData: imageData)
            await fetchUser() // Refresh user data
        } catch {
            print("Error uploading profile photo: \(error)")
        }
        isLoading = false
    }
    
    func uploadBanner(imageData: Data) async {
        isLoading = true
        do {
            try await userProfileService.uploadBanner(imageData: imageData)
            await fetchUser() // Refresh user data
        } catch {
            print("Error uploading banner: \(error)")
        }
        isLoading = false
    }
    
    func logout() {
        tokenStore.deleteToken()
        tabStore.tab = .maps
    }
}
