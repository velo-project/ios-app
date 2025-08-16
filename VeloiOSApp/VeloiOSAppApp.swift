//
//  VeloiOSAppApp.swift
//  VeloiOSApp
//
//  Created by Gabriel Araújo Lima on 30/07/25.
//

import SwiftUI

@main
struct VeloiOSAppApp: App {
    @StateObject var router = NavigationRouter()
    
    init() {
        TokenService().deleteToken()
    }
    
    var body: some Scene {
        WindowGroup {
            NavigationStack(path : $router.path) {
                MainAppView().navigationDestination(for: Route.self) { route in
                    switch route {
                    case .home:
                        MainAppView()
                    case .login:
                        LoginView(router: router)
                    }
                }
            }
            .preferredColorScheme(.light)
            .environment(\.font, .body)
            .environmentObject(router)
        }
    }
}
