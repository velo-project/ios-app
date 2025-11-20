//
//  SearchViewModel.swift
//  VeloiOSApp
//
//  Created by Gabriel Araújo on 19/11/25.
//

import Foundation
import Combine
import GooglePlaces

@MainActor
class SearchViewModel: ObservableObject {
    @Published var query: String = ""
    
    @Published var suggestions: [GMSAutocompleteSuggestion] = []
    @Published var errorMessage: String?
    
    private let placesManager: GoogleMapsPlacesManager
    private let locationService: MapsLocationServiceImpl
    private let tabStore = TabStore.shared
    private let sheetStore = SheetStore.shared
    private var cancellables = Set<AnyCancellable>()
    
    init(placesManager: GoogleMapsPlacesManager = GoogleMapsPlacesManager(), locationService: MapsLocationServiceImpl = MapsLocationServiceImpl()) {
        self.placesManager = placesManager
        self.locationService = locationService
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
        
        placesManager.fetchCoordinates(for: placeID) { [weak self] coordinate, destinationName, error in
            guard let self = self else { return }
              
            Task {
                let originName = try? await MapsLocationServiceImpl.shared.getCurrentAddress()
                
                await MainActor.run {
                    if let coordinate = coordinate, let destinationName = destinationName {
                        
                        LocationStore.shared.setLocation(name: destinationName, coordinate: coordinate, currentLocation: originName ?? "localização atual")
                        
                        self.tabStore.tab = .maps
                        
                        DispatchQueue.main.asyncAfter(deadline: .now() + 0.1) {
                            self.sheetStore.sheet = .startRoute
                        }
                        
                    } else {
                        self.errorMessage = "Não foi possível carregar os detalhes do local."
                    }
                }
            }
        }
    }
}
