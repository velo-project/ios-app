//
//  Track.swift
//  VeloiOSApp
//
//  Created by Gabriel Araújo on 13/11/25.
//

import Foundation

struct Track: Identifiable, Codable {
    var id = UUID()
    let lat: Double
    let lng: Double
    
    enum CodingKeys: String, CodingKey {
        case lat
        case lng
    }
}
