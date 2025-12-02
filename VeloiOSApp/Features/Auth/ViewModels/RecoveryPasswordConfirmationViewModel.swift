//
//  RecoveryPasswordConfirmationViewModel.swift
//  VeloiOSApp
//
//  Created by Gabriel Araújo Lima on 02/12/25.
//

import SwiftUI
import Foundation
import Sentry

class RecoveryPasswordConfirmationViewModel: ObservableObject {
    @Published var code: String = ""
    @Published var password: String = ""
    
    @Published var recoveryKey: String = ""
    
    private var authService = AuthService()
    
    func recoveryPasswordConfirmation() async -> Bool {
        do {
            try await authService.recoveryPasswordConfirmation(code: code, password: password)
            return true
        } catch {
            print("erro ocorreu: \(error)")
            SentrySDK.capture(error: error)
            return false
        }
    }
}
