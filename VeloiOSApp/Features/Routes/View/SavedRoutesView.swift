//
//  SavedRoutesView.swift
//  VeloiOSApp
//
//  Created by Gabriel Araújo Lima on 06/08/25.
//

import SwiftUI

struct SavedRoutesView: View {
    @StateObject private var viewModel = SavedRoutesViewModel()
    @StateObject private var routesStore = RoutesStore.shared
    
    var body: some View {
        VStack(alignment: .leading) {
            if !$routesStore.routes.isEmpty {
                ScrollView {
                    LazyVStack(spacing: 16) {
                        ForEach(routesStore.routes) { route in
                            VeloRouteCard(route: route)
                        }
                    }
                    .padding()
                    .frame(maxWidth: .infinity)
                }
                .frame(maxWidth: .infinity)
            }
            else {
                VStack(alignment: .center, spacing: 8) {
                    Text("você não tem rotas salvas").bold()
                    Text("salve suas rotas preferidas, todas elas apareceram aqui!")
                        .multilineTextAlignment(.center)
                }
                .frame(maxWidth: .infinity, maxHeight: .infinity)
            }
        }
        .navigationTitle("rotas")
        .task {
            await viewModel.loadRoutesIfNeed()
        }
        .alert("Ops!", isPresented: $viewModel.showError) {
            Button("OK", role: .cancel) { }
        } message: {
            Text(viewModel.errorMessage)
        }
    }
}

struct SavedRoutesView_Previews: PreviewProvider {
    static var previews: some View {
        SavedRoutesView()
    }
}
