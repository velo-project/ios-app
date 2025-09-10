//
//  SavedRoutesModel.swift
//  VeloiOSApp
//
//  Created by Gabriel Araújo Lima on 10/09/25.
//

import Foundation

struct SavedRoutesModel: Identifiable {
    var id: UUID = UUID()
    var initialLocation: String
    var finalLocation: String
    var lastTimeRun: Date
}
