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
    @Published var events: [Event] = []
    @Published var errorMessage: String?
    
    private let placesManager: GoogleMapsPlacesManager
    private let locationService: MapsLocationServiceImpl
    private let eventsService: EventsServiceable
    private let tabStore = TabStore.shared
    private let sheetStore = SheetStore.shared
    private var cancellables = Set<AnyCancellable>()
    
    init(
        placesManager: GoogleMapsPlacesManager = GoogleMapsPlacesManager(),
        locationService: MapsLocationServiceImpl = MapsLocationServiceImpl(),
        eventsService: EventsServiceable = APIClient()
    ) {
        self.placesManager = placesManager
        self.locationService = locationService
        self.eventsService = eventsService
        setupBindings()
    }
    
    private func setupBindings() {
        $query
            .receive(on: RunLoop.main)
            .sink { [weak self] text in
                self?.placesManager.query = text
                self?.searchEvents(query: text)
            }
            .store(in: &cancellables)
        
        placesManager.$places
            .receive(on: RunLoop.main)
            .assign(to: &$suggestions)
        
        placesManager.$errorMessage
            .receive(on: RunLoop.main)
            .assign(to: &$errorMessage)
    }
    
    private func searchEvents(query: String) {
        Task {
            do {
                let eventsResponse = try await eventsService.getEvents()
                var allEvents = eventsResponse.recommendedEvents
                allEvents.append(contentsOf: eventsResponse.trendingEvents)
                allEvents.append(contentsOf: eventsResponse.lastParticipatedEvents)
                allEvents.append(contentsOf: eventsResponse.subscribedEvents)
                
                let uniqueEvents = Array(Set(allEvents))
                
                if query.isEmpty {
                    self.events = uniqueEvents
                } else {
                    self.events = uniqueEvents.filter { event in
                        event.name.localizedCaseInsensitiveContains(query)
                    }
                }
            } catch {
                // Handle error, maybe set an error message
                print("Error searching events: \(error)")
            }
        }
    }
    
    func didSelectPlace(_ place: GMSAutocompleteSuggestion) {
        guard let placeID = place.placeSuggestion?.placeID else { return }
        
        LocationStore.shared.routePolyline = nil
        
        print("Iniciando busca de detalhes para ID: \(placeID)")
        
        placesManager.fetchCoordinates(for: placeID) { [weak self] coordinate, destinationName, error in
            guard let self = self else { return }
              
            Task {
                let originName = try? await MapsLocationServiceImpl.shared.getCurrentAddress()
                
                await MainActor.run {
                    if let coordinate = coordinate, let destinationName = destinationName {
                        
                        LocationStore.shared.setLocation(name: destinationName, coordinate: coordinate, currentLocation: originName ?? "localização atual")
                        
                        self.tabStore.tab = .maps
                        
                        LocationStore.shared.$routePolyline
                            .first(where: { $0 != nil })
                            .sink { [weak self] _ in
                                self?.sheetStore.sheet = .startRoute(route: nil)
                            }
                            .store(in: &self.cancellables)
                        
                    } else {
                        self.errorMessage = "Não foi possível carregar os detalhes do local."
                    }
                }
            }
        }
    }
}

extension Event: Hashable {
    public static func == (lhs: Event, rhs: Event) -> Bool {
        return lhs.id == rhs.id
    }
    
    public func hash(into hasher: inout Hasher) {
        hasher.combine(id)
    }
}
