//
//  EventsViewModel.swift
//  VeloiOSApp
//
//  Created by Gabriel Araújo Lima on 22/10/25.
//

import Foundation

@MainActor
class EventsViewModel: ObservableObject {
    @Published var recommendedEvents: [Event] = []
    @Published var trendingEvents: [Event] = []
    @Published var lastParticipatedEvents: [Event] = []
    @Published var subscribedEvents: [Event] = []
    
    @Published var selectedEvent: Event? = nil
    
    private let eventsService: EventsServiceable
    
    init(eventsService: EventsServiceable = APIClient()) {
        self.eventsService = eventsService
    }
    
    func loadEvents() async {
        do {
            let eventsResponse = try await eventsService.getEvents()
            self.recommendedEvents = eventsResponse.recommendedEvents
            self.trendingEvents = eventsResponse.trendingEvents
            self.lastParticipatedEvents = eventsResponse.lastParticipatedEvents
            self.subscribedEvents = eventsResponse.subscribedEvents
        } catch {
            print("Error loading events: \(error)")
        }
    }
    
    func subscribe(event: Event) async {
        do {
            let response = try await eventsService.subscribe(id: event.id)
            // Optionally, you can use the response message
            print(response.message)
            // After subscribing, reload the events to get the updated list of subscribed events
            await loadEvents()
        } catch {
            print("Error subscribing to event: \(error)")
        }
    }
    
    func getConfirmationCode(event: Event) async -> String? {
        do {
            let response = try await eventsService.getConfirmationCode(id: event.id)
            return response.confirmationCode
        } catch {
            print("Error getting confirmation code: \(error)")
            return nil
        }
    }
    
    func isSubscribed(to event: Event) -> Bool {
        return subscribedEvents.contains { $0.id == event.id }
    }
}

