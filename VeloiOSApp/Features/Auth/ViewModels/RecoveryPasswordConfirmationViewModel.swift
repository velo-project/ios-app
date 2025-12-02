//
//  RecoveryPasswordConfirmationViewModel.swift
//  VeloiOSApp
//
//  Created by Gabriel Araújo Lima on 02/12/25.
//

import SwiftUI
import Foundation

class RecoveryPasswordConfirmationViewModel: ObservableObject {
    @Published var code: String = ""
    @Published var password: String = ""
    
    private var authService = AuthService()
    
    func recoveryPasswordConfirmation() async -> Void {
        do {
            try await authService.recoveryPasswordConfirmation(code: code, password: password)
        } catch {
            print("erro ocorreu")
        }
    }
}
