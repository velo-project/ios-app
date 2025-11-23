//
//  HomeViewModel.swift
//  VeloiOSApp
//
//  Created by Gabriel Araújo Lima on 31/07/25.
//

import Foundation
import CoreLocation
import GoogleMaps

class HomeViewModel: ObservableObject {
    @Published var searchQuery: String = ""
    @Published var lastKnowLocation: CLLocationCoordinate2D?
    
    private var mapsLocationService = MapsLocationServiceImpl()
    private var tokenStore = TokenStore()
    private var routesAPIClient = RoutesAPIClient()
    private var routesStore = RoutesStore.shared
    
    init() {
        observeLocation()
    }
    
    private func observeLocation() {
        mapsLocationService.$lastKnowLocation.assign(to: &$lastKnowLocation)
    }
    
    func isAuthenticated() -> Bool {
        return tokenStore.getJwtToken().isAuthenticated
    }
    
    func saveRoute(initialLocation: String, finalLocation: String, polyline: String?) {
        guard let polyline = polyline, let path = GMSPath(fromEncodedPath: polyline) else {
            return
        }
        
        var tracks: [Track] = []
        for i in 0..<path.count() {
            let coordinate = path.coordinate(at: i)
            tracks.append(Track(id: UUID(), lat: Double(coordinate.latitude), lng: Double(coordinate.longitude)))
        }
        
        Task {
            do {
                try await routesAPIClient.newTrack(initialLocation: initialLocation, finalLocation: finalLocation, track: tracks)
                
                let route = try await routesAPIClient.getRoutes()
                routesStore.routes = route.tracks
            } catch {
                print("Error saving route: \(error)")
            }
        }
    }
    
    func deleteRoute(route: Route) async -> Bool {
        do {
            try await routesAPIClient.deleteRoute(id: route.id)
            routesStore.routes.removeAll { $0.id == route.id }
            return true
        } catch {
            print("Error deleting route: \(error)")
            return false
        }
    }
}
