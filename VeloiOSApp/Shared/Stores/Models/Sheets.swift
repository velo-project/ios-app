//
//  SheetStep.swift
//  VeloiOSApp
//
//  Created by Gabriel Araújo on 20/11/25.
//


enum Sheets: Identifiable {
    case login, mfa, register, startRoute(route: Route?), forgotPassword, recoveryPasswordConfirmation
    
    var id: Int {
        switch self {
        case .login: return 0
        case .mfa: return 1
        case .register: return 2
        case .startRoute: return 3
        case .forgotPassword: return 4
        case .recoveryPasswordConfirmation: return 5
        }
    }
}
