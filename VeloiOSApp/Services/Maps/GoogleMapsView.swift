//
//  GoogleMapsView.swift
//  VeloiOSApp
//
//  Created by Gabriel Araújo Lima on 16/10/25.
//

import SwiftUI
import GoogleMaps

struct GoogleMapsView: UIViewRepresentable {
    
    private let zoom: Float = 15.0
    
    @Binding var lastKnowLocation: CLLocationCoordinate2D?

    func makeUIView(context: Self.Context) -> GMSMapView {
        
        guard let lastKnowLocation = lastKnowLocation else {
            return GMSMapView()
        }

        let camera = GMSCameraPosition.camera(withTarget: lastKnowLocation, zoom: zoom)
        let mapView = GMSMapView.map(withFrame: .zero, camera: camera)
        return mapView
    }

    func updateUIView(_ mapView: GMSMapView, context: Context) {
        guard let lastKnowLocation = lastKnowLocation else {
            return
        }
        
        mapView.animate(toLocation: lastKnowLocation)
    }
}
