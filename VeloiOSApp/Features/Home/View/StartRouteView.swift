//
//  StartRouteView.swift
//  VeloiOSApp
//
//  Created by Gabriel Araújo on 20/11/25.
//

import Foundation
import SwiftUI
import GoogleMaps

struct StartRouteView: View {
    @Environment(\.dismiss) var dismiss
    
    @StateObject var viewModel = HomeViewModel()
    @StateObject var placesManager = GoogleMapsPlacesManager()
    
    var route: Route?
    var initialLocation: String
    var finalLocation: String
    var routePolyline: String?
    
    @State private var bookmarkStyle = "bookmark"
    
    init(route: Route) {
        self.route = route
        self.initialLocation = route.initialLocation
        self.finalLocation = route.finalLocation
        
        let path = GMSMutablePath()
        route.track.forEach { track in
            path.add(CLLocationCoordinate2D(latitude: track.lat, longitude: track.lng))
        }
        self.routePolyline = path.encodedPath()
    }
    
    init(initialLocation: String, finalLocation: String, routePolyline: String?) {
        self.route = nil
        self.initialLocation = initialLocation
        self.finalLocation = finalLocation
        self.routePolyline = routePolyline
    }
    
    
    private func deleteRoute(route: Route, viewModel: HomeViewModel) {
        Task {
            let deleted = await viewModel.deleteRoute(route: route)
            if deleted {
                dismiss()
            }
        }
    }
    
    var body: some View {
        VStack(alignment: .leading) {
            HStack(spacing: 8) {
                Spacer()
                Button(action: {
                    dismiss()
                }) {
                    Image(systemName: "xmark")
                        .resizable()
                        .scaledToFit()
                        .frame(width: 20, height: 20)
                        .bold()
                }
                .foregroundStyle(.black)
                
                if let routeToDelete = route {
                    Button(action: {
                        deleteRoute(route: routeToDelete, viewModel: viewModel)
                    }) {
                        Image(systemName: "trash")
                            .resizable()
                            .scaledToFit()
                            .frame(width: 20, height: 20)
                            .bold()
                    }
                    .foregroundStyle(.red)
                } else {
                    Button(action: {
                        if viewModel.isAuthenticated() {
                            if bookmarkStyle == "bookmark" {
                                bookmarkStyle = "bookmark.fill"
                                viewModel.saveRoute(initialLocation: initialLocation, finalLocation: finalLocation, polyline: routePolyline)
                            } else {
                                if route == nil {
                                    bookmarkStyle = "bookmark"
                                }
                            }
                        }
                    }) {
                        Image(systemName: bookmarkStyle)
                            .resizable()
                            .scaledToFit()
                            .frame(width: 20, height: 20)
                            .bold()
                    }
                    .foregroundStyle(.black)
                }
            }
            .padding()
            Spacer()
            VStack(alignment: .leading) {
                Text(initialLocation).bold()
                Image(systemName: "arrow.down").bold()
                Text(finalLocation).bold()
                if let travelTime = placesManager.travelTime {
                    Text("Tempo estimado: \(travelTime)")
                        .padding(.top)
                } else {
                    ProgressView()
                        .padding(.top)
                }
            }
            Spacer()
            VeloButton {
                Text("iniciar agora!")
            } action: {
                if let polyline = routePolyline, let path = GMSPath(fromEncodedPath: polyline) {
                    if path.count() >= 2 {
                        let startCoordinate = path.coordinate(at: 0)
                        let endCoordinate = path.coordinate(at: path.count() - 1)
                        
                        let saddr = "\(startCoordinate.latitude),\(startCoordinate.longitude)"
                        let daddr = "\(endCoordinate.latitude),\(endCoordinate.longitude)"
                        
                        if let url = URL(string: "comgooglemaps://?saddr=\(saddr)&daddr=\(daddr)&directionsmode=bicycling") {
                            if UIApplication.shared.canOpenURL(url) {
                                UIApplication.shared.open(url)
                            } else {
                                if let webUrl = URL(string: "https://www.google.com/maps/dir/?api=1&origin=\(saddr)&destination=\(daddr)&travelmode=bicycling") {
                                    UIApplication.shared.open(webUrl)
                                }
                            }
                        }
                    }
                }
                // Reset route in LocationStore
                LocationStore.shared.selectedLocation = nil
                LocationStore.shared.routePolyline = nil
                dismiss()
            }
        }
        .padding()
        .onAppear {
            if route != nil {
                bookmarkStyle = "bookmark.fill"
            }
            
            if let polyline = routePolyline, let path = GMSPath(fromEncodedPath: polyline) {
                if path.count() >= 2 {
                    let startCoordinate = path.coordinate(at: 0)
                    let endCoordinate = path.coordinate(at: path.count() - 1)
                    print("Fetching route from \(startCoordinate) to \(endCoordinate)")
                    placesManager.fetchRoute(from: startCoordinate, to: endCoordinate)
                }
            }
        }
    }
}
