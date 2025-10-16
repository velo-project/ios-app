//
//  VeloRouteCard.swift
//  VeloiOSApp
//
//  Created by Gabriel Araújo Lima on 16/10/25.
//

import SwiftUI

@ViewBuilder
private func VeloRouteCard(initialLocation: String, endLocation: String, lastTimeRun: Date) -> some View {
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
            Text(lastTimeRun.formattedBrazilian())
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
