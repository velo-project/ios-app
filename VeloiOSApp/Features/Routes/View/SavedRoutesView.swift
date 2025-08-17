//
//  SavedRoutesView.swift
//  VeloiOSApp
//
//  Created by Gabriel Araújo Lima on 06/08/25.
//

import SwiftUI

struct SavedRoutesView: View {
    var body: some View {
        VStack(alignment: .leading) {
            Text("rotas salvas").font(.title2).bold().padding()
            ScrollView {
                LazyVStack(spacing: 16) {
                    RouteCard(initialLocation: "alto da lapa", endLocation: "cidade universitária")
                }
                .padding()
                .frame(maxWidth: .infinity)
            }
            .frame(maxWidth: .infinity)
        }
    }
    
    @ViewBuilder
    private func RouteCard(initialLocation: String, endLocation: String) -> some View {
        VStack(alignment: .leading, spacing: 0) {
            VStack(alignment: .leading) {
                Text(initialLocation)
                Image(systemName: "arrow.down")
                Text(endLocation)
            }
            .padding(.vertical, 20)
            .bold()
            .frame(maxWidth: .infinity, alignment: .leading)
            .background(.white)
            .padding(.all, 25)
            
            VStack(alignment: .leading) {
                Text("passou por aqui em")
                    .font(.caption2)
                Text("12 de maio de 2025")
            }
            .frame(maxWidth: .infinity, alignment: .leading)
            .padding(.all, 25)
            .background(
                Color.black
                    .clipShape(
                        VeloRoundedCorner(radius: 20, corners: [.bottomLeft, .bottomRight])
                    )
            )
            .foregroundColor(.white)
            .bold()
        }
        .frame(maxWidth: .infinity)
        .background(.white)
        .clipShape(RoundedRectangle(cornerRadius: 20))
        .shadow(color: .black.opacity(0.1), radius: 6, x: 0, y: 4)
    }
}

struct SavedRoutesView_Previews: PreviewProvider {
    static var previews: some View {
        SavedRoutesView()
    }
}
