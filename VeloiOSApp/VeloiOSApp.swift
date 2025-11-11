//
//  VeloiOSAppApp.swift
//  VeloiOSApp
//
//  Created by Gabriel Araújo Lima on 30/07/25.
//

import SwiftUI
import GoogleMaps

@main
struct VeloiOSAppApp: App {
    @StateObject var router = NavigationRouter()
    
    init() {
        GMSServices.provideAPIKey("AIzaSyAai5EPkSARfPIkmvsDtd9AZY1dZW6UJOU")
    }
    
    var body: some Scene {
        WindowGroup {
            MainAppView()
                .preferredColorScheme(.light)
                .environment(\.font, .body)
                .environmentObject(router)
        }
    }
}
