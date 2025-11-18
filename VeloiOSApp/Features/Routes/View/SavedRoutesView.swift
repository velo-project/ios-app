//
//  SavedRoutesView.swift
//  VeloiOSApp
//
//  Created by Gabriel Araújo Lima on 06/08/25.
//

import SwiftUI

struct SavedRoutesView: View {
    @StateObject private var viewModel: SavedRoutesViewModel
    
    init(viewModel: SavedRoutesViewModel = SavedRoutesViewModel()) {
        _viewModel = StateObject(wrappedValue: viewModel)
    }
    
    var body: some View {
        VStack(alignment: .leading) {
            if !$viewModel.routes.isEmpty {
                ScrollView {
                    LazyVStack(spacing: 16) {
                        ForEach(viewModel.routes) { route in
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
    }
}

struct SavedRoutesView_Previews: PreviewProvider {
    static var previews: some View {
        SavedRoutesView()
    }
}
