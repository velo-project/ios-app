//
//  NavigationRouter.swift
//  VeloiOSApp
//
//  Created by Gabriel Araújo Lima on 30/07/25.
//

import Foundation
import SwiftUI
import Combine

enum AppRoute: Hashable {
    case home
    case login
}

final class NavigationRouter: ObservableObject {
    private let tabStore = TabStore.shared
    private var cancellables = Set<AnyCancellable>()
    
    @Published var path = NavigationPath()
    @Published var actualTab: Tabs
    
    init() {
        self.actualTab = tabStore.tab
        tabStore.$tab
            .sink { [weak self] newTab in
                self?.actualTab = newTab
            }
            .store(in: &cancellables)
        
    }
    
    func navigate(to route: AppRoute) {
        path.append(route)
    }
    
    func goBack() {
        path.removeLast()
    }
    
    func reset() {
        path = NavigationPath()
    }
}
