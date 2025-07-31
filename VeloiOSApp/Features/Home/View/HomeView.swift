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
    
    @State var region = MKCoordinateRegion(
        center: .init(latitude: 37.334_900,longitude: -122.009_020),
        span: .init(latitudeDelta: 0.2, longitudeDelta: 0.2)
    )
    
    var body: some View {
        ZStack {
            Map(coordinateRegion: $region)
            VStack {
                HStack(spacing: 4) {
                    TextField(
                        "Para onde vamos?",
                        text: $viewModel.searchQuery
                    )
                    .padding()
                    .frame(height: 50)
                    .background(.ultraThinMaterial)
                    .cornerRadius(50)
                    
                    Button(action: {
                        router.navigate(to: .login)
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
                HStack {
                    Button(action: {
                        viewModel.changeSelectedButton(button: 1)
                    }) {
                        
                        Image(systemName: "map")
                        if (viewModel.selectedButton == 1) {
                            Text("mapa")
                        }
                    }
                    .foregroundColor(.black)
                    
                    Spacer()
                    
                    Button(action: {
                        viewModel.changeSelectedButton(button: 2)
                    }) {
                        Image(systemName: "ticket")
                        if (viewModel.selectedButton == 2) {
                            Text("eventos")
                        }
                    }
                    .foregroundColor(.black)
                    
                    Spacer()
                    
                    Button(action: {
                        viewModel.changeSelectedButton(button: 3)
                    }) {
                        Image(systemName: "bookmark")
                        if (viewModel.selectedButton == 3) {
                            Text("rotas")
                        }
                    }
                    .foregroundColor(.black)
                    
                    Spacer()
                    
                    Button(action: {
                        viewModel.changeSelectedButton(button: 4)
                    }) {
                        Image(systemName: "person.2")
                        if (viewModel.selectedButton == 4) {
                            Text("amigos")
                        }
                    }
                    .foregroundColor(.black)
                }
                .padding()
                .padding(.horizontal, 20)
                .frame(maxWidth: .infinity)
                .frame(height: 50)
                .background(.ultraThinMaterial)
                .cornerRadius(50)
            }
            .padding()
            
        }
        
    }
}

struct HomeView_Previews: PreviewProvider {
    static var previews: some View {
        HomeView()
    }
}
