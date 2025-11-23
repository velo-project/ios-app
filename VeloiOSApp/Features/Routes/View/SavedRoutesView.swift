//
//  SavedRoutesView.swift
//  VeloiOSApp
//
//  Created by Gabriel Araújo Lima on 06/08/25.
//

import SwiftUI
import GoogleMaps

struct SavedRoutesView: View {
    @StateObject private var viewModel = SavedRoutesViewModel()
    @StateObject private var routesStore = RoutesStore.shared
    @ObservedObject private var sheetStore = SheetStore.shared
    @ObservedObject private var tabStore = TabStore.shared
    @ObservedObject private var locationStore = LocationStore.shared
    
    var body: some View {
        VStack(alignment: .leading) {
            if !$routesStore.routes.isEmpty {
                ScrollView {
                    LazyVStack(spacing: 16) {
                        ForEach(routesStore.routes) { route in
                            VeloRouteCard(route: route)
                                .onTapGesture {
                                    
                                    let path = GMSMutablePath()
                                    route.track.forEach { track in
                                        path.add(CLLocationCoordinate2D(latitude: track.lat, longitude: track.lng))
                                    }
                                    locationStore.routePolyline = path.encodedPath()
                                    
                                    if let lastTrack = route.track.last {
                                        let endCoordinate = CLLocationCoordinate2D(latitude: lastTrack.lat, longitude: lastTrack.lng)
                                        locationStore.setLocation(name: route.finalLocation, coordinate: endCoordinate, currentLocation: route.initialLocation)
                                    }
                                    
                                    tabStore.tab = .maps
                                    sheetStore.sheet = .startRoute(route: route)
                                }
                        }
                    }
                    .padding()
                    .frame(maxWidth: .infinity)
                }
                .frame(maxWidth: .infinity)
            }
            else {
                VStack(alignment: .center, spacing: 8) {
                    Text("você não tem rotas salvas").bold()
                    Text("salve suas rotas preferidas, todas elas apareceram aqui!")
                        .multilineTextAlignment(.center)
                }
                .frame(maxWidth: .infinity, maxHeight: .infinity)
            }
        }
        .navigationTitle("rotas")
        .task {
            await viewModel.loadRoutesIfNeed()
        }
        .alert("Ops!", isPresented: $viewModel.showError) {
            Button("OK", role: .cancel) { }
        } message: {
            Text(viewModel.errorMessage)
        }
    }
}

struct SavedRoutesView_Previews: PreviewProvider {
    static var previews: some View {
        SavedRoutesView()
    }
}
