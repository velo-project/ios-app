//
//  MainAppView.swift
//  VeloiOSApp
//
//  Created by Gabriel Araújo Lima on 31/07/25.
//

import SwiftUI

struct MainAppView: View {
    @EnvironmentObject var router: NavigationRouter
    
    @State private var selectedTab = 0
    @State private var queryText = "" // TODO Refactor to Store
    @State private var showLoginPage = false
    
    private var tokenStore = TokenStore()
    
    var body: some View {
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
                    LoginView(selectedTab: $selectedTab)
                }
                
                Tab("rotas", systemImage: "bookmark", value: 5) {
                    SavedRoutesView()
                }
                
                Tab("amigos", systemImage: "person.2", value: 6) {
                    LoginView(selectedTab: $selectedTab)
                    
                }
            }
            
            Tab(value: 7, role: .search) {
                SearchView(queryText: $queryText)
            }
        }
        .sheet(isPresented: $showLoginPage) {
            LoginView(selectedTab: $selectedTab)
        }
        .tint(.green)
        .onChange(of: selectedTab) { _, newTab in
            switch newTab {
            case 1, 2, 3:
                showLoginPage = true
                break
            default:
                showLoginPage = false
                break
            }
        }
    }
}

#Preview {
    MainAppView()
}
