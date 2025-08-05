//
//  HomeView.swift
//  VeloiOSApp
//
//  Created by Gabriel Araújo Lima on 30/07/25.
//

import SwiftUI
import MapKit

struct HomeView: View {    
    @EnvironmentObject var router: NavigationRouter
    @StateObject var viewModel = HomeViewModel()
    
    var body: some View {
        ZStack {
            if let region = viewModel.region {
                Map(coordinateRegion: .constant(region))
                    .ignoresSafeArea()
            } else {
                Text("carregando suas informações...")
            }
            
            VStack {
                HStack(spacing: 4) {
                    TextField(
                        "para onde vamos?",
                        text: $viewModel.searchQuery
                    )
                    .padding()
                    .frame(height: 50)
                    .background(.ultraThinMaterial)
                    .cornerRadius(50)
                    
                    Button(action: {
                        if !viewModel.isAuthenticated() {
                            router.navigate(to: .login)
                            return
                        }                        
                    }) {
                        Image(systemName: "person")
                            .foregroundColor(.black)
                    }
                    .padding()
                    .frame(height: 50)
                    .background(.ultraThinMaterial)
                    .cornerRadius(50)
                }
                
                Spacer()
            }
            .padding()
            .padding(.top, 10)
        }
        
    }
}

struct HomeView_Previews: PreviewProvider {
    static var previews: some View {
        HomeView()
    }
}
