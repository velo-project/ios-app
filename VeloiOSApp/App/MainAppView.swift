//
//  MainAppView.swift
//  VeloiOSApp
//
//  Created by Gabriel Araújo Lima on 31/07/25.
//

import SwiftUI

struct MainAppView: View {
    @EnvironmentObject var router: NavigationRouter
    
    @State private var queryText = ""
    @State private var code = ""
    @State private var isLoading = false
    
    @State private var eventsPath: [ViewDestination] = []
    @State private var homePath: [ViewDestination] = []
    @State private var routesPath: [ViewDestination] = []
    @State private var socialPath: [ViewDestination] = []
    
    @ObservedObject private var tokenStore = TokenStore.shared
    private let authService = AuthService()
    
    @ObservedObject private var sheetStore = SheetStore.shared
    @ObservedObject private var tabStore = TabStore.shared
    @ObservedObject private var locationStore = LocationStore.shared
    
    var body: some View {
        ZStack {
            TabView(selection: $tabStore.tab) {
                Tab("mapa", systemImage: "map", value: .maps) {
                    NavigationStack(path: $homePath) {
                        HomeView()
                            .veloCommonToolbar {
                                if tokenStore.isAuthenticated {
                                    homePath.append(.userProfile)
                                } else {
                                    sheetStore.sheet = .login
                                }
                            }
                            .veloUserProfileNavigation()
                    }
                }
                
                Tab("eventos", systemImage: "ticket", value: .events) {
                    if tokenStore.isAuthenticated {
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
                    if tokenStore.isAuthenticated {
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
                    if tokenStore.isAuthenticated {
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
            .sheet(item: $sheetStore.sheet) { sheet in
                switch sheet {
                case .login:
                    LoginView(isLoading: $isLoading)
                        .presentationDragIndicator(.visible)
                case .register:
                    RegisterView(isLoading: $isLoading)
                        .presentationDragIndicator(.visible)
                case .forgotPassword:
                    ForgotPasswordView(isLoading: $isLoading)
                        .presentationDragIndicator(.visible)
                case .recoveryPasswordConfirmation:
                    RecoveryPasswordConfirmationView(isLoading: $isLoading)
                        .presentationDragIndicator(.visible)
                case .mfa:
                    MFAView(code: $code, isLoading: $isLoading)
                        .presentationDragIndicator(.visible)
                case .startRoute(let route):
                    if let route = route {
                        StartRouteView(route: route)
                            .presentationDetents([.fraction(0.4)])
                            .interactiveDismissDisabled()
                    } else {
                        StartRouteView(initialLocation: locationStore.currentLocation ?? "Minha localização", finalLocation: locationStore.selectedLocation?.name ?? "Destino Desconhecido", routePolyline: locationStore.routePolyline)
                            .presentationDetents([.fraction(0.4)])
                            .interactiveDismissDisabled()
                    }
                }
            }
            .tint(.green)
            .onChange(of: tabStore.tab) { _, newTab in
                if !tokenStore.isAuthenticated {
                    switch newTab {
                    case .events, .routes, .communities:
                        sheetStore.sheet = .login
                    default:
                        sheetStore.sheet = nil
                    }
                }
            }
            .onReceive(NotificationCenter.default.publisher(for: AppNotifications.userDidBecomeUnauthorized)) { _ in
                tokenStore.deleteToken()
                tabStore.tab = .maps
                isLoading = false
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
