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
    
    private var router: NavigationRouter
    private var authService = AuthService()
    private var tokenService = TokenService()
    
    init(router: NavigationRouter) {
        self.router = router
    }
    
    func login() {
        let token = authService.login(email: email, password: password)
        if (token.isAuthenticated) {
            router.reset()
        }
    }
}
