//
//  HomeViewModel.swift
//  VeloiOSApp
//
//  Created by Gabriel Araújo Lima on 31/07/25.
//

import Foundation
import MapKit

class HomeViewModel: ObservableObject {
    @Published var searchQuery: String = ""
    @Published var region: MKCoordinateRegion?
    
    private var mapsLocationService = MapsLocationServiceImpl()
    
    init() {
        observeLocation()
    }
    
    private func observeLocation() {
        mapsLocationService.$lastKnowLocation
            .compactMap { $0 }
            .map { coordinate in
                MKCoordinateRegion(
                    center: coordinate,
                    span: MKCoordinateSpan(latitudeDelta: 0.01, longitudeDelta: 0.01)
                )
            }
            .assign(to: &$region)
    }
}
