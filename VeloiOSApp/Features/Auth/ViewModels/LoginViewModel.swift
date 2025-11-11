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
    
    func login() async -> Void {
        do {
            try await authService.login(email: email, password: password)
        } catch {
            print("erro ocorreu")
        }
        
        
    }
}
