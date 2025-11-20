//
//  MapsLocationService.swift
//  VeloiOSApp
//
//  Created by Gabriel Araújo Lima on 30/07/25.
//

import Foundation
import CoreLocation
import MapKit

class MapsLocationServiceImpl: NSObject, CLLocationManagerDelegate, ObservableObject {
    
    // Singleton para acesso fácil
    static let shared = MapsLocationServiceImpl()
    
    @Published var lastKnowLocation: CLLocationCoordinate2D?
    
    private var manager = CLLocationManager()
    private let geocoder = CLGeocoder()
    
    override init() {
        super.init()
        manager.delegate = self
        manager.startUpdatingLocation()
        checkLocationAuthorization()
    }
    
    private func checkLocationAuthorization() {
        switch manager.authorizationStatus {
        case .notDetermined:
            manager.requestWhenInUseAuthorization()
        case .restricted:
            print("Location restricted")
        case .denied:
            print("Location denied")
        case .authorizedAlways, .authorizedWhenInUse:
            lastKnowLocation = manager.location?.coordinate
        @unknown default:
            print("Unknown authorization status")
        }
    }
    
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        guard let location = locations.last else { return }
        DispatchQueue.main.async {
            self.lastKnowLocation = location.coordinate
        }
    }
    
    func getCurrentAddress() async throws -> String? {
        guard let location = manager.location else {
            return nil
        }
    
        let placemarks = try await geocoder.reverseGeocodeLocation(location)
        
        if let place = placemarks.first {
            let street = place.thoroughfare ?? ""
            let number = place.subThoroughfare ?? ""
            let neighborhood = place.subLocality ?? ""
            let city = place.locality ?? ""
            
            if !street.isEmpty {
                return "\(street), \(number) - \(neighborhood)"
            } else {
                return neighborhood.isEmpty ? city : neighborhood
            }
        }
        
        return nil
    }
}
