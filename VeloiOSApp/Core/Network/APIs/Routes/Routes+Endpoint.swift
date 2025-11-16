//
//  Routes+Endpoint.swift
//  VeloiOSApp
//
//  Created by Gabriel Araújo on 13/11/25.
//

import Foundation

enum RoutesEndpoint: Endpoint {
    case newTrack(initialLocation: String, finalLocation: String, track: [Track])
    case getRoutes
    case deleteRoute(id: Int)
    
    var path: String {
        switch self {
        case .newTrack: return "/api/routes/v1/track"
        case .getRoutes: return "/api/routes/v1/track"
        case .deleteRoute(let id): return "/api/routes/v1/track/\(id)"
        }
    }
    
    var method: String {
        switch self {
        case .newTrack: return "POST"
        case .getRoutes: return "GET"
        case .deleteRoute(_): return "DELETE"
        }
    }
    
    var queryItems: [URLQueryItem]? {
        switch self {
        default:
            return nil
        }
    }
    
    var headers: [String: String]? {
        let token = TokenStore().getJwtToken().token ?? ""
        var baseHeaders: [String: String] = [
            "Accept": "application/json",
            "Content-Type": "application/json"
        ]
        
        baseHeaders["Authorization"] = token
        return baseHeaders
    }
    
    var body: Data? {
        switch self {
        case .newTrack(let initialLocation, let finalLocation, let track): return try? JSONSerialization.data(withJSONObject: [
            "initial_location": initialLocation,
            "final_location": finalLocation,
            "track": track.map({ track in [
                "lat": track.lat,
                "lng": track.lng
            ]
            })
        ])
        default: return nil
        }
    }
    
    
}
