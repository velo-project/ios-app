//
//  AuthService.swift
//  VeloiOSApp
//
//  Created by Gabriel Araújo Lima on 05/08/25.
//

import Foundation

actor AuthService {
    private let tokenStore: TokenStore
    private let apiClient: UserAPIClient
    
    init(apiClient: UserAPIClient = UserAPIClient(), tokenStore: TokenStore = TokenStore()) {
        self.tokenStore = tokenStore
        self.apiClient = apiClient
    }
    
    func login(email: String, password: String) async throws -> LoginKeyResponse {
        let mfaCode = try await apiClient.login(email: email, password: password)
        
        return mfaCode
    }
    
    func verifyCode(key: String, code: String) async throws -> Bool {
        let token = try await apiClient.verify2FACode(key: key, code: code)
        
        
        tokenStore.saveJwtToken(token: token.accessToken)
        return true
    }
}
