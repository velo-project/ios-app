//
//  VeloiOSAppApp.swift
//  VeloiOSApp
//
//  Created by Gabriel Araújo Lima on 30/07/25.
//

import SwiftUI
import Sentry
import GoogleMaps
import GooglePlaces

@main
struct VeloiOSAppApp: App {
    @StateObject var router = NavigationRouter()
    
    init() {
        GMSServices.provideAPIKey("AIzaSyAai5EPkSARfPIkmvsDtd9AZY1dZW6UJOU")
        GMSPlacesClient.provideAPIKey("AIzaSyAai5EPkSARfPIkmvsDtd9AZY1dZW6UJOU")
        //TokenStore().deleteToken()
        SentrySDK.start { options in
            options.dsn = "https://88123cd172b9c6817dffa767f53df322@o4510060605538304.ingest.us.sentry.io/4510395115044864"
            
            // Adds IP for users.
            // For more information, visit: https://docs.sentry.io/platforms/apple/data-management/data-collected/
            options.sendDefaultPii = true
            
            // Set tracesSampleRate to 1.0 to capture 100% of transactions for performance monitoring.
            // We recommend adjusting this value in production.
            options.tracesSampleRate = 1.0
            
            // Configure profiling. Visit https://docs.sentry.io/platforms/apple/profiling/ to learn more.
            options.configureProfiling = {
                $0.sessionSampleRate = 1.0 // We recommend adjusting this value in production.
                $0.lifecycle = .trace
            }
            
            // Uncomment the following lines to add more data to your events
            // options.attachScreenshot = true // This adds a screenshot to the error events
            // options.attachViewHierarchy = true // This adds the view hierarchy to the error events
            
            // Enable experimental logging features
            options.experimental.enableLogs = true
        }
        // Remove the next line after confirming that your Sentry integration is working.
        SentrySDK.capture(message: "This app uses Sentry! :)")
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
