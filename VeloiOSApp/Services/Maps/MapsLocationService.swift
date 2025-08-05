//
//  MapsLocationService.swift
//  VeloiOSApp
//
//  Created by Gabriel Araújo Lima on 30/07/25.
//

import Foundation
import CoreLocation

class MapsLocationServiceImpl: NSObject, CLLocationManagerDelegate, ObservableObject {
    @Published var lastKnowLocation: CLLocationCoordinate2D?
    
    private var manager = CLLocationManager()
    
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
            print("restricted")
        case .denied:
            print("denied")
        case .authorizedAlways:
            print("tres bien monsieur")
        case .authorizedWhenInUse:
            lastKnowLocation = manager.location?.coordinate
        @unknown default:
            print("jsais pas")
        }
    }
    
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        guard let location = locations.last else { return }
        DispatchQueue.main.async {
            self.lastKnowLocation = location.coordinate
        }
    }
}
