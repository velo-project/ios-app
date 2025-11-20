//
//  TargetLocation.swift
//  VeloiOSApp
//
//  Created by Gabriel Araújo on 19/11/25.
//

import Foundation
import CoreLocation

struct TargetLocation: Identifiable, Equatable {
    let id = UUID()
    let name: String
    let coordinate: CLLocationCoordinate2D
    
    static func == (lhs: TargetLocation, rhs: TargetLocation) -> Bool {
        return lhs.id == rhs.id
    }
}
