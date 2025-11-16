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
        .navigationTitle("rotas")
        .veloCommonToolbar()
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
