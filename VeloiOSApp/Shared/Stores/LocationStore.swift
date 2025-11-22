//
//  LocationStore.swift
//  VeloiOSApp
//
//  Created by Gabriel Araújo on 19/11/25.
//

import Foundation
import CoreLocation

class LocationStore: ObservableObject {
    static let shared = LocationStore()
    
    @Published var selectedLocation: TargetLocation?
    @Published var currentLocation: String?
    @Published var routePolyline: String?
    
    private init() { }
    
    func setLocation(name: String, coordinate: CLLocationCoordinate2D, currentLocation: String) {
        self.selectedLocation = TargetLocation(name: name, coordinate: coordinate)
        self.currentLocation = currentLocation
    }
}
