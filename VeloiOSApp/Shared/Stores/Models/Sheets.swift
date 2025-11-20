//
//  SheetStep.swift
//  VeloiOSApp
//
//  Created by Gabriel Araújo on 20/11/25.
//


enum Sheets: Identifiable {
    case login, mfa, startRoute
    
    var id: Int {
        switch self {
        case .login: return 0
        case .mfa: return 1
        case .startRoute: return 2
        }
    }
}
