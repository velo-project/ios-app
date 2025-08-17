//
//  SecretsService.swift
//  VeloiOSApp
//
//  Created by Gabriel Araújo Lima on 05/08/25.
//

import Foundation
import KeychainSwift

class TokenStore {
    private var keychan = KeychainSwift()
    
    func saveJwtToken(token: String) {
        deleteToken()
        keychan.set(token, forKey: "com.velo.jwt.token")
    }
    
    func getJwtToken() -> JwtToken {
        guard let token = keychan.get("com.velo.jwt.token") else {
            return JwtToken(token: nil)
        }
        
        return JwtToken(token: token)
    }
    
    func deleteToken() {
        keychan.delete("com.velo.jwt.token")
    }
}

struct JwtToken {
    var token: String?
    var isAuthenticated: Bool {
        token != nil
    }
}
