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
    
    init() {
        self.forYouEvents = (1...5).map { index in
            BrandEventsModel(imageUrl: "https://picsum.photos/seed/foryou\(index)/480/280")
        }
        
        self.trendingEvents = (1...5).map { index in
            BrandEventsModel(imageUrl: "https://picsum.photos/seed/trending\(index)/480/280")
        }
        
        self.lastKnowEvents = (1...5).map { index in
            BrandEventsModel(imageUrl: "https://picsum.photos/seed/lastknow\(index)/480/280")
        }
    }
}
