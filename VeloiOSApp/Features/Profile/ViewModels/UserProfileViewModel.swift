//
//  UserProfileViewModel.swift
//  VeloiOSApp
//
//  Created by Gabriel Araújo Lima on 26/11/25.
//

import SwiftUI
import Foundation
import Sentry

@MainActor
class UserProfileViewModel: ObservableObject {
    @Published var user: User?
    @Published var isLoading = false
    
    private var userProfileService = UserProfileService()
    private var authService = AuthService()
    
    @ObservedObject private var tokenStore = TokenStore.shared
    @ObservedObject private var tabStore = TabStore.shared
    
    func fetchUser() async {
        isLoading = true
        do {
            let response = try await userProfileService.fetchUser()
            user = response.user
        } catch {
            SentrySDK.capture(error: error)
        }
        isLoading = false
    }
    
    func logout() {
        tokenStore.deleteToken()
        tabStore.tab = .maps
    }
}
