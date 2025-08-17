//
//  AuthService.swift
//  VeloiOSApp
//
//  Created by Gabriel Araújo Lima on 05/08/25.
//

import Foundation

class AuthService {
    private var tokenStore = TokenStore()
    
    func login(email: String, password: String) -> JwtToken {
        // mock response
        tokenStore.saveJwtToken(token: "nice-token")
        
        return tokenStore.getJwtToken()
    }
}
