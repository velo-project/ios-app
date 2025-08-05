//
//  AuthService.swift
//  VeloiOSApp
//
//  Created by Gabriel Araújo Lima on 05/08/25.
//

import Foundation

class AuthService {
    private var tokenService = TokenService()
    
    func login(email: String, password: String) -> JwtToken {
        // mock response
        tokenService.saveJwtToken(token: "nice-token")
        
        return tokenService.getJwtToken()
    }
}
