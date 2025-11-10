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
            TabView(selection: $selectedTab) {
                Tab("mapa", systemImage: "map", value: 0) {
                    HomeView()
                }
                
                if !tokenStore.getJwtToken().isAuthenticated {
                    Tab("eventos", systemImage: "ticket", value: 1) {
                        Text("faça login para continuar")
                    }
                    
                    Tab("rotas", systemImage: "bookmark", value: 2) {
                        Text("faça login para continuar")
                    }
                    
                    Tab("amigos", systemImage: "person.2", value: 3) {
                        Text("faça login para continuar")
                    }
                } else {
                    Tab("eventos", systemImage: "ticket", value: 4) {
                        EventsView()
                    }
                    
                    Tab("rotas", systemImage: "bookmark", value: 5) {
                        SavedRoutesView()
                    }
                    
                    Tab("amigos", systemImage: "person.2", value: 6) {
                        CommunitiesView()
                    }
                }
                
                Tab(value: 7, role: .search) {
                    SearchView(queryText: $queryText)
                }
            }
            .sheet(item: $activePage) { page in
                switch page {
                case .login:
                    LoginView(activePage: $activePage, isLoading: $isLoading)
                case .mfa:
                    MFAView(selectedTab: $selectedTab, code: $code, isLoading: $isLoading)
                }
            }
            .tint(.green)
            .onChange(of: selectedTab) { _, newTab in
                switch newTab {
                case 1, 2, 3:
                    activePage = .login
                default:
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
