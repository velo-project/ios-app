//
//  SecretsService.swift
//  VeloiOSApp
//
//  Created by Gabriel Araújo Lima on 05/08/25.
//

import Foundation
import KeychainSwift

class TokenStore: ObservableObject {
    static let shared = TokenStore()
    private var keychan = KeychainSwift()
    private var nicknameStore = NicknameStore.shared

    @Published var isAuthenticated: Bool = false

    private init() {
        self.isAuthenticated = getJwtToken().isAuthenticated
    }

    func saveJwtToken(token: String) {
        deleteToken()
        keychan.set(token, forKey: "com.velo.jwt.token")

        let tokenParts = token.split(separator: ".").map(String.init)
        if tokenParts.count == 3 {
            if let claims = decodeJWTPart(tokenParts[1]), let nickname = claims["nickname"] as? String {
                nicknameStore.saveNickname(nickname: nickname)
            }
        }

        DispatchQueue.main.async {
            self.isAuthenticated = true
        }
    }

    func getJwtToken() -> JwtToken {
        guard let token = keychan.get("com.velo.jwt.token") else {
            return JwtToken(token: nil)
        }

        return JwtToken(token: token)
    }

    func deleteToken() {
        keychan.delete("com.velo.jwt.token")
        nicknameStore.deleteNickname()
        DispatchQueue.main.async {
            self.isAuthenticated = false
        }
    }
}

struct JwtToken {
    var token: String?
    var isAuthenticated: Bool {
        token != nil
    }
}
