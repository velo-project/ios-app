//
//  SavedRoutesViewModel.swift
//  VeloiOSApp
//
//  Created by Gabriel Araújo Lima on 10/09/25.
//

import Foundation

class SavedRoutesViewModel: ObservableObject {
    @Published var routes: [Route] = []
    
    private let api: RoutesAPIClient
    
    init(api: RoutesAPIClient = RoutesAPIClient()) {
        self.api = api
    }
    
    private func loadRoutes() async -> [Route]? {
        do {
            let route = try await api.getRoutes()
            return route.tracks
        } catch {
            print("erro aqui na saved routes essa porra")
            return nil
        }
    }
    
    @MainActor
    func loadRoutesIfNeed() async {
        if routes.isEmpty {
            guard let routes = await loadRoutes() else {
                return
            }
            self.routes = routes
        }
    }
}
