import Foundation

struct EventsResponse: Codable {
    let recommendedEvents: [Event]
    let trendingEvents: [Event]
    let lastParticipatedEvents: [Event]
    let subscribedEvents: [Event]

    enum CodingKeys: String, CodingKey {
        case recommendedEvents = "recommended_events"
        case trendingEvents = "trending_events"
        case lastParticipatedEvents = "last_participated_events"
        case subscribedEvents = "subscribed_events"
    }
}

struct Event: Codable, Identifiable {
    let id: String
    let name: String
    let description: String
    let date: String
    let location: String
    let imageUrl: String

    enum CodingKeys: String, CodingKey {
        case id
        case name
        case description
        case date
        case location
        case imageUrl = "image_url"
    }
}
