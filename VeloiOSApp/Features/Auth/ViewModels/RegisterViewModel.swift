//
//  RegisterViewModel.swift
//  VeloiOSApp
//
//  Created by Gabriel Araújo Lima on 26/11/25.
//

import SwiftUI
import Foundation

class RegisterViewModel: ObservableObject {
    @Published var name: String = ""
    @Published var nickname: String = ""
    @Published var email: String = ""
    @Published var password: String = ""
    
    private var authService = AuthService()
    
    func register() async -> Void {
        do {
            try await authService.register(name: name, nickname: nickname, email: email, password: password)
        } catch {
            print("erro ocorreu")
        }
    }
}
