// GoogleMapsView.swift
import SwiftUI
import GoogleMaps
import CoreLocation

struct GoogleMapsView: UIViewRepresentable {
    
    private let zoom: Float = 14.0
    
    var targetLocation: TargetLocation?
    @Binding var lastKnowLocation: CLLocationCoordinate2D?
    
    @ObservedObject private var sheetStore = SheetStore.shared
    @State private var hasAnimatedToUserLocation = false
    
    private let apiKey = "AIzaSyAai5EPkSARfPIkmvsDtd9AZY1dZW6UJOU"
    
    func makeCoordinator() -> Coordinator {
        Coordinator(self)
    }
    
    func makeUIView(context: Context) -> GMSMapView {
        let camera = GMSCameraPosition.camera(
            withLatitude: lastKnowLocation?.latitude ?? -23.5505,
            longitude: lastKnowLocation?.longitude ?? -46.6333,
            zoom: zoom
        )
        let mapView = GMSMapView.map(withFrame: .zero, camera: camera)
        mapView.isMyLocationEnabled = true
        mapView.delegate = context.coordinator
        return mapView
    }
    
    func updateUIView(_ mapView: GMSMapView, context: Context) {
        mapView.clear()
        
        var bottomPadding: CGFloat = 0
        if case .startRoute = sheetStore.sheet {
            bottomPadding = UIScreen.main.bounds.height * 0.4
        }
        mapView.padding.bottom = bottomPadding
        
        if let destination = targetLocation {
            let marker = GMSMarker()
            marker.position = destination.coordinate
            marker.title = destination.name
            marker.map = mapView
            
            if let polyline = LocationStore.shared.routePolyline, let path = GMSPath(fromEncodedPath: polyline) {
                drawPath(from: polyline, mapView: mapView)
                let bounds = GMSCoordinateBounds(path: path)
                let update = GMSCameraUpdate.fit(bounds, withPadding: 50.0)
                mapView.animate(with: update)
            } else if let origin = lastKnowLocation {
                fetchRoute(from: origin, to: destination.coordinate, mapView: mapView)
                
                let bounds = GMSCoordinateBounds(coordinate: origin, coordinate: destination.coordinate)
                let update = GMSCameraUpdate.fit(bounds, withPadding: 50.0)
                mapView.animate(with: update)
            } else {
                let camera = GMSCameraPosition.camera(withTarget: destination.coordinate, zoom: zoom)
                mapView.animate(to: camera)
            }
        } else {
            if let userLocation = lastKnowLocation, !hasAnimatedToUserLocation {
                let camera = GMSCameraPosition.camera(withTarget: userLocation, zoom: zoom)
                mapView.animate(to: camera)
                
                DispatchQueue.main.async {
                    hasAnimatedToUserLocation = true
                }
            }
        }
    }
    
    func fetchRoute(from source: CLLocationCoordinate2D, to destination: CLLocationCoordinate2D, mapView: GMSMapView) {
        let session = URLSession.shared
        
        let urlString = "https://maps.googleapis.com/maps/api/directions/json?origin=\(source.latitude),\(source.longitude)&destination=\(destination.latitude),\(destination.longitude)&mode=bicycling&key=\(apiKey)"
        
        guard let url = URL(string: urlString) else { return }
        
        session.dataTask(with: url) { data, response, error in
            guard let data = data, error == nil else { return }
            
            do {
                if let json = try JSONSerialization.jsonObject(with: data, options: []) as? [String: Any],
                   let routes = json["routes"] as? [[String: Any]],
                   let route = routes.first,
                   let overviewPolyline = route["overview_polyline"] as? [String: Any],
                   let points = overviewPolyline["points"] as? String {
                    
                    DispatchQueue.main.async {
                        LocationStore.shared.routePolyline = points
                        drawPath(from: points, mapView: mapView)
                    }
                }
            } catch {
                print("Erro ao decodificar rota: \(error)")
            }
        }.resume()
    }
    
    func drawPath(from points: String, mapView: GMSMapView) {
        guard let path = GMSPath(fromEncodedPath: points) else { return }
        
        let borderColor: UIColor = .init(red: 0.0, green: 0.89, blue: 0.0, alpha: 1.0)
        
        let polylineBorder = GMSPolyline(path: path)
        polylineBorder.strokeWidth = 9.0
        polylineBorder.strokeColor = borderColor
        polylineBorder.map = mapView
        
        let polyline = GMSPolyline(path: path)
        polyline.strokeWidth = 5.0
        polyline.strokeColor = .green
        polyline.map = mapView
        
        if path.count() > 1 {
            let startPoint = path.coordinate(at: 0)
            let endPoint = path.coordinate(at: path.count() - 1)
            
            let startCap = GMSCircle(position: startPoint, radius: 4)
            startCap.fillColor = borderColor
            startCap.strokeColor = .clear
            startCap.map = mapView
        
            let endCap = GMSCircle(position: endPoint, radius: 4)
            endCap.fillColor = borderColor
            endCap.strokeColor = .clear
            endCap.map = mapView
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
