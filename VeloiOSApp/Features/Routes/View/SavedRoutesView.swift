//
//  SavedRoutesView.swift
//  VeloiOSApp
//
//  Created by Gabriel Araújo Lima on 06/08/25.
//

import SwiftUI

struct SavedRoutesView: View {
    private var viewModel = SavedRoutesViewModel()
    
    var body: some View {
        VStack(alignment: .leading) {
            ScrollView {
                LazyVStack(spacing: 16) {
                    ForEach(viewModel.routes) { route in
                        VeloRouteCard(
                            initialLocation: route.initialLocation,
                            endLocation: route.finalLocation,
                            lastTimeRun: route.lastTimeRun)
                    }
                }
                .padding()
                .frame(maxWidth: .infinity)
            }
            .frame(maxWidth: .infinity)
        }
        .navigationTitle("rotas")
        .veloCommonToolbar()
    }
}

struct SavedRoutesView_Previews: PreviewProvider {
    static var previews: some View {
        SavedRoutesView()
    }
}
