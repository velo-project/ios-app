//
//  RoutesApiResponse.swift
//  VeloiOSApp
//
//  Created by Gabriel Araújo on 13/11/25.
//

struct Tracks: Codable {
    let message: String
    let tracks: [Route]
    let statusCode: Int
    
    enum CodingKeys: String, CodingKey {
        case message
        case statusCode = "status_code"
        case tracks
    }
}
