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
    
    private var userProfileService = UserProfileService()
    private var authService = AuthService()
    
    @ObservedObject private var tokenStore = TokenStore.shared
    @ObservedObject private var tabStore = TabStore.shared
    
    // Hardcoded for now, should be dynamically retrieved
    private let nickname = "g" 
    
    func fetchUser() async {
        do {
            user = try await userProfileService.fetchUser(nickname: nickname)
        } catch {
            print("Error fetching user: \(error)")
        }
    }
    
    func uploadProfilePhoto(imageData: Data) async {
        do {
            try await userProfileService.uploadProfilePhoto(imageData: imageData)
            await fetchUser() // Refresh user data
        } catch {
            print("Error uploading profile photo: \(error)")
        }
    }
    
    func uploadBanner(imageData: Data) async {
        do {
            try await userProfileService.uploadBanner(imageData: imageData)
            await fetchUser() // Refresh user data
        } catch {
            print("Error uploading banner: \(error)")
        }
    }
    
    func logout() {
        tokenStore.deleteToken()
        tabStore.tab = .maps
    }
}
