import Foundation

protocol EventsServiceable {
    func getEvents() async throws -> EventsResponse
    func subscribe(id: String) async throws -> SubscribeResponse
    func getConfirmationCode(id: String) async throws -> ConfirmationCodeResponse
}

extension APIClient: EventsServiceable {
    func getEvents() async throws -> EventsResponse {
        return try await request(EventsEndpoint.getEvents)
    }

    func subscribe(id: String) async throws -> SubscribeResponse {
        return try await request(EventsEndpoint.subscribe(id: id))
    }

    func getConfirmationCode(id: String) async throws -> ConfirmationCodeResponse {
        return try await request(EventsEndpoint.getConfirmationCode(id: id))
    }
}
