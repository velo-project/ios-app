//
//  Route.swift
//  VeloiOSApp
//
//  Created by Gabriel Araújo on 13/11/25.
//

import Foundation

struct Route: Identifiable, Codable {
    let id: Int
    let userId: Int
    let initialLocation: String
    let finalLocation: String
    let visitedAt: Date
    let track: [Track]
    
    enum CodingKeys: String, CodingKey {
        case id
        case userId = "user_id"
        case initialLocation = "initial_location"
        case finalLocation = "final_location"
        case visitedAt = "visited_at"
        case track
    }
}
