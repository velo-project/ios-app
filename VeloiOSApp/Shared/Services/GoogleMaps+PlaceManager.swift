//
//  GoogleMaps+PlaceManager.swift
//  VeloiOSApp
//
//  Created by Gabriel Araújo on 19/11/25.
//

import Foundation
import GooglePlaces
import Combine
import CoreLocation
import GoogleMaps

struct GMDirectionsResponse: Codable {
    let routes: [GMDirectionsRoute]
}

struct GMDirectionsRoute: Codable {
    let legs: [GMDirectionsLeg]
    let overview_polyline: GMDirectionsOverviewPolyline
}

struct GMDirectionsLeg: Codable {
    let duration: GMDirectionsDuration
}

struct GMDirectionsDuration: Codable {
    let text: String
}

struct GMDirectionsOverviewPolyline: Codable {
    let points: String
}

class GoogleMapsPlacesManager: ObservableObject {
    @Published var query: String = ""
    @Published var places: [GMSAutocompleteSuggestion] = []
    @Published var errorMessage: String?
    @Published var route: GMSPath?
    @Published var travelTime: String?

    private var client: GMSPlacesClient?
    private var token: GMSAutocompleteSessionToken?
    private var cancellables = Set<AnyCancellable>()

    init() {
        $query
            .debounce(for: .milliseconds(500), scheduler: RunLoop.main)
            .removeDuplicates()
            .sink { [weak self] searchText in
                self?.fetchPlaces(from: searchText)
            }
            .store(in: &cancellables)
    }

    private func fetchPlaces(from searchText: String) {
        guard !searchText.isEmpty else {
            self.places = []
            self.errorMessage = nil
            return
        }

        if client == nil { client = GMSPlacesClient.shared() }
        if token == nil { token = GMSAutocompleteSessionToken() }

        let request = GMSAutocompleteRequest(query: searchText)
        request.sessionToken = token

        client?.fetchAutocompleteSuggestions(from: request) { [weak self] (results, error) in
            DispatchQueue.main.async {
                if let error = error {
                    let nsError = error as NSError
                    if nsError.code != GMSPlacesErrorCode.RawValue() {
                        self?.errorMessage = "Erro: \(error.localizedDescription)"
                    }
                    return
                }

                self?.places = results ?? []
                self?.errorMessage = nil
            }
        }
    }

    func fetchCoordinates(for placeID: String, completion: @escaping (CLLocationCoordinate2D?, String?, Error?) -> Void) {
        if client == nil { client = GMSPlacesClient.shared() }

        let fields: GMSPlaceField = [.name, .coordinate]

        client?.fetchPlace(fromPlaceID: placeID, placeFields: fields, sessionToken: token) { (place, error) in
            self.token = nil

            if let error = error {
                completion(nil, nil, error)
                return
            }

            if let place = place {
                completion(place.coordinate, place.name, nil)
            }
        }
    }

    func fetchRoute(from origin: CLLocationCoordinate2D, to destination: CLLocationCoordinate2D) {
        let session = URLSession.shared
        let apiKey = "AIzaSyAai5EPkSARfPIkmvsDtd9AZY1dZW6UJOU"
        let url = "https://maps.googleapis.com/maps/api/directions/json?origin=\(origin.latitude),\(origin.longitude)&destination=\(destination.latitude),\(destination.longitude)&mode=bicycling&key=\(apiKey)"

        guard let url = URL(string: url) else {
            return
        }
        
        Task {
            do {
                let (data, _) = try await session.data(from: url)
                if let dataString = String(data: data, encoding: .utf8) {
                    print("Google Maps Directions API Response: \(dataString)")
                }
                let decoder = JSONDecoder()
                let directionsResponse = try decoder.decode(GMDirectionsResponse.self, from: data)

                if let route = directionsResponse.routes.first, let leg = route.legs.first {
                    DispatchQueue.main.async {
                        self.travelTime = leg.duration.text
                        self.route = GMSPath(fromEncodedPath: route.overview_polyline.points)
                    }
                }
            } catch {
                print("Error fetching or decoding directions: \(error)")
            }
        }
    }
}
