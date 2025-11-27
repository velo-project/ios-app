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
    private let keyStore: MFAKeyStore
    
    init(apiClient: UserAPIClient = UserAPIClient(), tokenStore: TokenStore = TokenStore(), keyStore: MFAKeyStore = MFAKeyStore()) {
        self.tokenStore = tokenStore
        self.apiClient = apiClient
        self.keyStore = keyStore
    }
    
    func login(email: String, password: String) async throws -> Void {
        let mfaCode = try await apiClient.login(email: email, password: password)
        
        keyStore.saveKey(key: mfaCode.key)
    }
    
    func verifyCode(code: String) async throws -> Bool {
        guard let key = keyStore.getKey(), !key.isEmpty else {
            return false
        }
        
        let token = try await apiClient.verify2FACode(key: key, code: code)
        
        tokenStore.saveJwtToken(token: token.accessToken)
        return true
    }

    func register(name: String, nickname: String, email: String, password: String) async throws {
        _ = try await apiClient.register(name: name, nickname: nickname, email: email, password: password)
        try await login(email: email, password: password)
    }

    func logout() {
        tokenStore.deleteToken()
    }
}
