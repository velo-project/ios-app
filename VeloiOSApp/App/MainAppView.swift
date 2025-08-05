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
    var body: some View {
        TabView {
            Group {
                HomeView().tabItem {
                    Label("mapa", systemImage: "map")
                }
                
                
                LoginView().tabItem {
                    Label("eventos", systemImage: "ticket")
                }
                LoginView().tabItem {
                    Label("rotas", systemImage: "bookmark")
                }
                LoginView().tabItem {
                    Label("amigos", systemImage: "person.2")
                }
            }
            .toolbarBackground(.ultraThinMaterial, for: .tabBar)
            .toolbarBackground(.visible, for: .tabBar)
        }
        .tint(.green)
    }
}

struct MainAppView_Previews: PreviewProvider {
    static var previews: some View {
        MainAppView()
    }
}
