// GoogleMapsView.swift
import SwiftUI
import GoogleMaps
import CoreLocation

struct GoogleMapsView: UIViewRepresentable {
    
    private let zoom: Float = 17.0
    
    @Binding var lastKnowLocation: CLLocationCoordinate2D?
    @State private var hasAnimatedToUserLocation = false
    
    func makeCoordinator() -> Coordinator {
        Coordinator(self)
    }
    
    func makeUIView(context: Context) -> GMSMapView {
        let camera = GMSCameraPosition.camera(
            withLatitude: lastKnowLocation?.latitude ?? -23.5505,
            longitude: lastKnowLocation?.longitude ?? -46.6333,
            zoom: 15.0
        )
        let mapView = GMSMapView.map(withFrame: .zero, camera: camera)
        mapView.isMyLocationEnabled = true
        
        mapView.delegate = context.coordinator
        
        return mapView
    }
    
    func updateUIView(_ mapView: GMSMapView, context: Context) {
        if let userLocation = lastKnowLocation, !hasAnimatedToUserLocation {
            mapView.animate(to: GMSCameraPosition.camera(withTarget: userLocation, zoom: zoom))
        }
    }
    
    class Coordinator: NSObject, GMSMapViewDelegate {
        var parent: GoogleMapsView
        
        init(_ parent: GoogleMapsView) {
            self.parent = parent
        }
    
        func mapView(_ mapView: GMSMapView, idleAt position: GMSCameraPosition) {
            if !parent.hasAnimatedToUserLocation {
                parent.hasAnimatedToUserLocation = true
            }
        }
    }
}
