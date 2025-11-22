//
//  SavedRoutesViewModel.swift
//  VeloiOSApp
//
//  Created by Gabriel Araújo Lima on 10/09/25.
//

import Foundation
import Sentry
import Combine

class SavedRoutesViewModel: ObservableObject {
    private let routesStore = RoutesStore.shared
    
    @Published var showError: Bool = false
    @Published var errorMessage: String = ""
    
    private let api: RoutesAPIClient
    
    init(api: RoutesAPIClient = RoutesAPIClient()) {
        self.api = api
    }
    
    private func loadRoutes() async throws -> [Route]? {
        //        do {
        let route = try await api.getRoutes()
        return route.tracks
        //        } catch {
        //            print("erro aqui na saved routes essa porra")
        //            return nil
        //        }
    }
    
    @MainActor
    func loadRoutesIfNeed() async {
        // Só carrega se estiver vazio
        if routesStore.routes.isEmpty {
            do {
                // Tenta carregar
                guard let loadedRoutes = try await loadRoutes() else { return }
                self.routesStore.routes = loadedRoutes
            } catch {
                // Se der erro (401, 500, sem internet), cai aqui
                print("Erro capturado: \(error.localizedDescription)")
                SentrySDK.capture(message: error.localizedDescription)
                
                // Prepara a mensagem para o usuário
                self.errorMessage = "Não foi possível carregar: \(error.localizedDescription)"
                self.showError = true
            }
        }
    }
}
