//
//  MainAppView.swift
//  VeloiOSApp
//
//  Created by Gabriel Araújo Lima on 31/07/25.
//

import SwiftUI

enum SheetStep: Identifiable {
    case login, mfa
    
    var id: Int {
        switch self {
        case .login: return 0
        case .mfa: return 1
        }
    }
}

struct MainAppView: View {
    @EnvironmentObject var router: NavigationRouter
    
    @State private var selectedTab = 0
    @State private var queryText = "" // TODO Refactor to Store
    @State private var code = ""
    @State private var activePage: SheetStep? = nil
    @State private var isLoading = false
    
    private var tokenStore = TokenStore()
    
    var body: some View {
        ZStack {
            TabView(selection: $router.actualTab) {
                Tab("mapa", systemImage: "map", value: .maps) {
                    HomeView()
                }
                
                Tab("eventos", systemImage: "ticket", value: .events) {
                    if tokenStore.getJwtToken().isAuthenticated {
                        EventsView()
                    } else {
                        Text("Faça login para continuar")
                    }
                }
                
                Tab("rotas", systemImage: "bookmark", value: .routes) {
                    if tokenStore.getJwtToken().isAuthenticated {
                        SavedRoutesView()
                    } else {
                        Text("Faça login para continuar")
                    }
                }
                
                Tab("amigos", systemImage: "person.2", value: .communities) {
                    if tokenStore.getJwtToken().isAuthenticated {
                        CommunitiesView()
                    } else {
                        Text("Faça login para continuar")
                    }
                }
                
                Tab(value: .search, role: .search) {
                    SearchView(queryText: $queryText)
                }
            }
            .sheet(item: $activePage) { page in
                switch page {
                case .login:
                    LoginView(activePage: $activePage, isLoading: $isLoading)
                case .mfa:
                    MFAView(code: $code, isLoading: $isLoading)
                }
            }
            .tint(.green)
            .onChange(of: router.actualTab) { _, newTab in
                if !tokenStore.getJwtToken().isAuthenticated {
                    switch newTab {
                    case .events, .routes, .communities:
                        activePage = .login
                    default:
                        activePage = nil
                    }
                } else {
                    activePage = nil
                }
            }
            
            if isLoading {
                Color.white
                    .ignoresSafeArea()
                
                ProgressView()
                    .scaleEffect(2)
            }
        }
    }
}

#Preview {
    MainAppView()
}
