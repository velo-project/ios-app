//
//  LoginViewModel.swift
//  VeloiOSApp
//
//  Created by Gabriel Araújo Lima on 31/07/25.
//

import SwiftUI
import Foundation

class LoginViewModel: ObservableObject {
    @Published var email: String = ""
    @Published var password: String = ""
    
    private var authService = AuthService()
    
    func login() -> JwtToken {
        let token = authService.login(email: email, password: password)
        return token
    }
}
