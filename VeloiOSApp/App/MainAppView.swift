//
//  MainAppView.swift
//  VeloiOSApp
//
//  Created by Gabriel Araújo Lima on 31/07/25.
//

import SwiftUI

enum Tab {
    case home, events, routes, friends
}

struct MainAppView: View {
    @EnvironmentObject var router: NavigationRouter
    
    @State private var selectedTab = 0
    
    private var tokenService = TokenService()
    
    var body: some View {
        TabView(selection: $selectedTab) {
            Group {
                HomeView().tabItem {
                    Label("mapa", systemImage: "map")
                }
                .tag(0)
                
                if !tokenService.getJwtToken().isAuthenticated {
                    Text("faça login para continuar").tabItem {
                        Label("eventos", systemImage: "ticket")
                    }
                    .tag(1)
                    
                    Text("faça login para continuar").tabItem {
                        Label("rotas", systemImage: "bookmark")
                    }
                    .tag(2)
                    Text("faça login para continuar").tabItem {
                        Label("amigos", systemImage: "person.2")
                    }
                    .tag(3)
                    
                } else {
                    LoginView(router: router).tabItem {
                        Label("eventos", systemImage: "ticket")
                    }
                    .tag(4)
                    
                    SavedRoutesView().tabItem {
                        Label("rotas", systemImage: "bookmark")
                    }
                    .tag(5)
                    
                    LoginView(router: router).tabItem {
                        Label("amigos", systemImage: "person.2")
                    }
                    .tag(6)
                }
            }
            .toolbarBackground(.ultraThinMaterial, for: .tabBar)
            .toolbarBackground(.visible, for: .tabBar)
        }
        .tint(.green)
        .onChange(of: selectedTab) { tab in
            switch tab {
            case 1, 2, 3:
                print("No Auth")
                router.navigate(to: .login)
            default:
                print("Auth")
                break
            }
        }
    }
}

struct MainAppView_Previews: PreviewProvider {
    static var previews: some View {
        MainAppView()
    }
}
