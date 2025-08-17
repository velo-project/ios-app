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
        if let region = viewModel.region {
            Map(coordinateRegion: .constant(region))
                .ignoresSafeArea()
        } else {
            Text("carregando suas informações...")
        }
        
    }
}

struct HomeView_Previews: PreviewProvider {
    static var previews: some View {
        HomeView()
    }
}
