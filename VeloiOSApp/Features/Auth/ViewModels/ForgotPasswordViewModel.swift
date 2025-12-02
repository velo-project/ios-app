//
//  ForgotPasswordViewModel.swift
//  VeloiOSApp
//
//  Created by Gabriel Araújo Lima on 02/12/25.
//

import SwiftUI
import Foundation

class ForgotPasswordViewModel: ObservableObject {
    @Published var email: String = ""
    
    private var authService = AuthService()
    
    func forgotPassword() async -> Void {
        do {
            try await authService.forgotPassword(email: email)
        } catch {
            print("erro ocorreu")
        }
    }
}
