//
//  SearchViewModel.swift
//  VeloiOSApp
//
//  Created by Gabriel Araújo on 19/11/25.
//

import Foundation
import Combine
import GooglePlaces

class SearchViewModel: ObservableObject {
    @Published var query: String = ""
    
    @Published var suggestions: [GMSAutocompleteSuggestion] = []
    @Published var errorMessage: String?
    
    private let placesManager: GoogleMapsPlacesManager
    private var cancellables = Set<AnyCancellable>()
    
    init(placesManager: GoogleMapsPlacesManager = GoogleMapsPlacesManager()) {
        self.placesManager = placesManager
        setupBindings()
    }
    
    private func setupBindings() {
        $query
            .receive(on: RunLoop.main)
            .sink { [weak self] text in
                self?.placesManager.query = text
            }
            .store(in: &cancellables)
        
        placesManager.$places
            .receive(on: RunLoop.main)
            .assign(to: &$suggestions)
        
        placesManager.$errorMessage
            .receive(on: RunLoop.main)
            .assign(to: &$errorMessage)
    }
    
    func didSelectPlace(_ place: GMSAutocompleteSuggestion) {
        guard let placeID = place.placeSuggestion?.placeID else { return }
        
        print("Iniciando busca de detalhes para ID: \(placeID)")
        
        placesManager.fetchCoordinates(for: placeID) { [weak self] coordinate, name, error in
            DispatchQueue.main.async {
                if let coordinate = coordinate, let name = name {
                    
                    LocationStore.shared.setLocation(name: name, coordinate: coordinate)
                    print("Local salvo na Store: \(name) - \(coordinate)")
                                        
//                    self?.placesManager.selectPlace(place)
                    
                } else {
                    self?.errorMessage = "Não foi possível carregar os detalhes do local."
                }
            }
        }
    }
}
