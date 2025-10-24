//
//  BrandEventsModel.swift
//  VeloiOSApp
//
//  Created by Gabriel Araújo Lima on 22/10/25.
//

import Foundation

public struct BrandEventsModel: Identifiable {
    public let id = UUID()
    var imageUrl: String
    var title: String
    var description: String
}
