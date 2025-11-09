//
//  APIClient.swift
//  VeloiOSApp
//
//  Created by Gabriel Araújo on 08/11/25.
//

import Foundation

final class APIClient {
    func request<T: Decodable>(_ endpoint: Endpoint) async throws -> T {
        let (data, response) = try await URLSession.shared.data(for: endpoint.request)
        guard let http = response as? HTTPURLResponse, (200...299).contains(http.statusCode) else {
            throw URLError(.badServerResponse)
        }
        return try JSONDecoder().decode(T.self, from: data)
    }
    
    func requestNoResponse(_ endpoint: Endpoint) async throws {
        let (_, response) = try await URLSession.shared.data(for: endpoint.request)
        guard let http = response as? HTTPURLResponse, (200...299).contains(http.statusCode) else {
            throw URLError(.badServerResponse)
        }
    }
}
