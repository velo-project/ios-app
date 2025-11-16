//
//  Routes+APIClient.swift
//  VeloiOSApp
//
//  Created by Gabriel Araújo on 13/11/25.
//

final class RoutesAPIClient {
    private let api: APIClient
    
    init(api: APIClient = APIClient()) {
        self.api = api
    }
    
    func newTrack(initialLocation: String, finalLocation: String, track: [Track]) async throws {
        try await api.requestNoResponse(RoutesEndpoint.newTrack(
            initialLocation: initialLocation,
            finalLocation: finalLocation,
            track: track))
    }
    
    func getRoutes() async throws -> Tracks {
        try await api.request(RoutesEndpoint.getRoutes)
    }
    
    func deleteRoute(id: Int) async throws {
        try await api.requestNoResponse(RoutesEndpoint.deleteRoute(id: id))
    }
}
