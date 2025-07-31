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
                        "para onde vamos?",
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
