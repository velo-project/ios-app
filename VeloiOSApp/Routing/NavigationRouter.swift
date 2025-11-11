//
//  NavigationRouter.swift
//  VeloiOSApp
//
//  Created by Gabriel Araújo Lima on 30/07/25.
//

import Foundation
import SwiftUI

enum Route: Hashable {
    case home
    case login
}

enum Tabs: Hashable {
    case login
    case maps
    case events
    case routes
    case communities
    case search
}

final class NavigationRouter: ObservableObject {
    @Published var path = NavigationPath()
    @Published var actualTab: Tabs = .maps
    
    func navigate(to route: Route) {
        path.append(route)
    }
    
    func goBack() {
        path.removeLast()
    }
    
    func reset() {
        path = NavigationPath()
    }
}
