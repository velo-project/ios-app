//
//  HomeView.swift
//  VeloiOSApp
//
//  Created by Gabriel Araújo Lima on 30/07/25.
//

import SwiftUI

struct HomeView: View {
    @EnvironmentObject var router: NavigationRouter
    @StateObject var viewModel = HomeViewModel()
    @StateObject var locationStore = LocationStore.shared
    
    var body: some View {
        GoogleMapsView(targetLocation: locationStore.selectedLocation,
                       lastKnowLocation: $viewModel.lastKnowLocation)
            .ignoresSafeArea()
    }
}

struct HomeView_Previews: PreviewProvider {
    static var previews: some View {
        HomeView()
    }
}
