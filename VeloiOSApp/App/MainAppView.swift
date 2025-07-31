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
    @State private var selectedTab: Tab = .home
    
    var body: some View {
        ZStack(alignment: .bottom) {
            Group {
                switch selectedTab {
                case .home:
                    HomeView()
                case .events:
                    LoginView() // mock
                case .routes:
                    LoginView() // mock
                case .friends:
                    LoginView() // mock
                }
            }
            .frame(maxWidth: .infinity, maxHeight: .infinity)
            .ignoresSafeArea()
            
            HStack {
                tabButton(tab: .home, icon: "map", label: "mapa")
                Spacer()
                tabButton(tab: .events, icon: "ticket", label: "eventos")
                Spacer()
                tabButton(tab: .routes, icon: "bookmark", label: "rotas")
                Spacer()
                tabButton(tab: .friends, icon: "person.2", label: "amigos")
            }
            .padding(.horizontal, 20)
            .padding(.vertical, 15)
            .background(.ultraThinMaterial)
            .cornerRadius(50)
            .padding()
        }
    }
    
    func tabButton(tab: Tab, icon: String, label: String) -> some View {
        Button(action: {
            selectedTab = tab
        }){
            HStack(spacing: 5) {
                Image(systemName: icon)
                if (selectedTab == tab) {
                    Text(label)
                }
            }
            .padding(.all, 7)
            .padding(.horizontal, 2)
            .foregroundColor(.black)
            .background(selectedTab == tab ? .green.opacity(0.2) : .clear)
            .cornerRadius(25)
        }
        
    }
}

struct MainAppView_Previews: PreviewProvider {
    static var previews: some View {
        MainAppView()
    }
}
