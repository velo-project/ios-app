//
//  SavedRoutesViewModel.swift
//  VeloiOSApp
//
//  Created by Gabriel Araújo Lima on 10/09/25.
//

import Foundation

class SavedRoutesViewModel: ObservableObject {
    @Published var routes: [SavedRoutesModel] = []
    
    init() {
        loadMockData()
    }
    
    private func loadMockData() {
        routes = [
            SavedRoutesModel(initialLocation: "São Paulo", finalLocation: "Rio de Janeiro", lastTimeRun: Date()),
            SavedRoutesModel(initialLocation: "Belo Horizonte", finalLocation: "Vitória", lastTimeRun: Date().addingTimeInterval(-86400)),
            SavedRoutesModel(initialLocation: "Curitiba", finalLocation: "Florianópolis", lastTimeRun: Date().addingTimeInterval(-172800)),
            SavedRoutesModel(initialLocation: "Porto Alegre", finalLocation: "Gramado", lastTimeRun: Date().addingTimeInterval(-259200)),
            SavedRoutesModel(initialLocation: "Fortaleza", finalLocation: "Jericoacoara", lastTimeRun: Date().addingTimeInterval(-345600)),
            SavedRoutesModel(initialLocation: "Recife", finalLocation: "Olinda", lastTimeRun: Date().addingTimeInterval(-432000)),
            SavedRoutesModel(initialLocation: "Manaus", finalLocation: "Presidente Figueiredo", lastTimeRun: Date().addingTimeInterval(-518400)),
            SavedRoutesModel(initialLocation: "Salvador", finalLocation: "Morro de São Paulo", lastTimeRun: Date().addingTimeInterval(-604800)),
            SavedRoutesModel(initialLocation: "Brasília", finalLocation: "Goiânia", lastTimeRun: Date().addingTimeInterval(-691200)),
            SavedRoutesModel(initialLocation: "Belém", finalLocation: "Alter do Chão", lastTimeRun: Date().addingTimeInterval(-777600))
        ]
    }
}
