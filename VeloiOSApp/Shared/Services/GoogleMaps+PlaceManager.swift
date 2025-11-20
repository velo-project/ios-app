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

class GoogleMapsPlacesManager: ObservableObject {
    @Published var query: String = ""
    @Published var places: [GMSAutocompleteSuggestion] = []
    @Published var errorMessage: String?
    
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
}
