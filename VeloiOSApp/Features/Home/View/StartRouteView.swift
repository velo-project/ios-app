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
    
    var initialLocation: String
    var finalLocation: String
    var routePolyline: String?
    
    @State private var bookmarkStyle = "bookmark"
    
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
                
                Button(action: {
                    if viewModel.isAuthenticated() {
                        if bookmarkStyle == "bookmark" {
                            bookmarkStyle = "bookmark.fill"
                            viewModel.saveRoute(initialLocation: initialLocation, finalLocation: finalLocation, polyline: routePolyline)
                        } else {
                            bookmarkStyle = "bookmark"
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
