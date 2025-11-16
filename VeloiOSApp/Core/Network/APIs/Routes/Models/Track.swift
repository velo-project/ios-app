//
//  Track.swift
//  VeloiOSApp
//
//  Created by Gabriel Araújo on 13/11/25.
//

import Foundation

struct Track: Identifiable, Codable {
    let id: Int
    let lat: Float
    let lng: Float
}
