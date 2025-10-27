//
//  EventsViewModel.swift
//  VeloiOSApp
//
//  Created by Gabriel Araújo Lima on 22/10/25.
//

import Foundation

class EventsViewModel: ObservableObject {
    @Published var forYouEvents: [BrandEventsModel]
    @Published var trendingEvents: [BrandEventsModel]
    @Published var lastKnowEvents: [BrandEventsModel]
    @Published var subscribedEvents: [BrandEventsModel] = []
    
    @Published var selectedEvent: BrandEventsModel? = nil
    
    init() {
        self.forYouEvents = (1...5).map { index in
            BrandEventsModel(imageUrl: "https://picsum.photos/seed/foryou\(index)/480/280", title: "lorem 1", description: "lorem 1")
        }
        
        self.trendingEvents = (1...5).map { index in
            BrandEventsModel(imageUrl: "https://picsum.photos/seed/trending\(index)/480/280", title: "lorem 2", description: "lorem 2")
        }
        
        self.lastKnowEvents = (1...5).map { index in
            BrandEventsModel(imageUrl: "https://picsum.photos/seed/lastknow\(index)/480/280", title: "lorem 3", description: "lorem 3")
        }
    }
    
    func subscribe(event: BrandEventsModel) {

    }
}
