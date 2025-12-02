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
    private let recoveryKeyStore: RecoveryKeyStore
    
    init(apiClient: UserAPIClient = UserAPIClient(), tokenStore: TokenStore = TokenStore.shared, keyStore: MFAKeyStore = MFAKeyStore(), recoveryKeyStore: RecoveryKeyStore = RecoveryKeyStore.shared) {
        self.tokenStore = tokenStore
        self.apiClient = apiClient
        self.keyStore = keyStore
        self.recoveryKeyStore = recoveryKeyStore
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

    func forgotPassword(email: String) async throws {
        let response = try await apiClient.forgotPassword(email: email)
        
        if let key = response.key {
            recoveryKeyStore.saveKey(key: key)
        }
    }

    func recoveryPasswordConfirmation(code: String, password: String) async throws {
        guard let key = recoveryKeyStore.getKey(), !key.isEmpty else {
            return
        }
        _ = try await apiClient.recoveryPasswordConfirmation(key: key, code: code, password: password)
        recoveryKeyStore.deleteKey()
    }
}
