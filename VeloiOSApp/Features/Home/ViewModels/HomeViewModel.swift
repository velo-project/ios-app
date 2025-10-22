//
//  HomeViewModel.swift
//  VeloiOSApp
//
//  Created by Gabriel Araújo Lima on 31/07/25.
//

import Foundation
import CoreLocation

class HomeViewModel: ObservableObject {
    @Published var searchQuery: String = ""
    @Published var lastKnowLocation: CLLocationCoordinate2D?
    
    private var mapsLocationService = MapsLocationServiceImpl()
    private var tokenStore = TokenStore()
    
    init() {
        observeLocation()
    }
    
    private func observeLocation() {
        mapsLocationService.$lastKnowLocation.assign(to: &$lastKnowLocation)
    }
    
    func isAuthenticated() -> Bool {
        return tokenStore.getJwtToken().isAuthenticated
    }
}
