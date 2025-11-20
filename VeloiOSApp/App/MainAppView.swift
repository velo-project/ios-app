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
    
    @State private var queryText = ""
    @State private var code = ""
    @State private var activePage: SheetStep? = nil
    @State private var isLoading = false
    
    @State private var eventsPath: [ViewDestination] = []
    @State private var homePath: [ViewDestination] = []
    @State private var routesPath: [ViewDestination] = []
    @State private var socialPath: [ViewDestination] = []
    
    private var tokenStore = TokenStore()
    
    var body: some View {
        ZStack {
            TabView(selection: $router.actualTab) {
                Tab("mapa", systemImage: "map", value: .maps) {
                    NavigationStack(path: $homePath) {
                        HomeView()
                            .veloCommonToolbar {
                                if tokenStore.getJwtToken().isAuthenticated {
                                    homePath.append(.userProfile)
                                } else {
                                    activePage = .login
                                }
                            }
                            .veloUserProfileNavigation()
                    }
                }
                
                Tab("eventos", systemImage: "ticket", value: .events) {
                    if tokenStore.getJwtToken().isAuthenticated {
                        NavigationStack(path: $eventsPath) {
                            EventsView()
                                .veloCommonToolbar {
                                    eventsPath.append(.userProfile)
                                }
                                .veloUserProfileNavigation()
                        }
                    } else {
                        Text("Faça login para continuar")
                    }
                }
                
                Tab("rotas", systemImage: "bookmark", value: .routes) {
                    if tokenStore.getJwtToken().isAuthenticated {
                        NavigationStack(path: $routesPath) {
                            SavedRoutesView()
                                .veloCommonToolbar {
                                    routesPath.append(.userProfile)
                                }
                                .veloUserProfileNavigation()
                        }
                    } else {
                        Text("Faça login para continuar")
                    }
                }
                
                Tab("amigos", systemImage: "person.2", value: .communities) {
                    if tokenStore.getJwtToken().isAuthenticated {
                        NavigationStack(path: $socialPath) {
                            CommunitiesView()
                                .veloCommonToolbar {
                                    socialPath.append(.userProfile)
                                }
                                .veloUserProfileNavigation()
                        }
                    } else {
                        Text("Faça login para continuar")
                    }
                }
                
                Tab(value: .search, role: .search) {
                    SearchView()
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
