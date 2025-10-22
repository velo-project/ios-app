//
//  VeloEventComponent.swift
//  VeloiOSApp
//
//  Created by Gabriel Araújo Lima on 22/10/25.
//

import Foundation
import SwiftUI

@ViewBuilder
public func VeloEventComponent(event: BrandEventsModel) -> some View {
    AsyncImage(url: URL(string: event.imageUrl)) { phase in
        switch phase {
        case .success(let image):
            image
                .resizable()
                .aspectRatio(contentMode: .fill)

        case .failure(_):
            ZStack {
                Color.gray.opacity(0.3)
                Image(systemName: "photo.on.rectangle.angled")
                    .font(.largeTitle)
                    .foregroundColor(.gray)
            }

        case .empty:
            ZStack {
                Color.gray.opacity(0.3)
                ProgressView()
            }

        @unknown default:
            EmptyView()
        }
    }
    .frame(width: 240, height: 140)
    .clipShape(RoundedRectangle(cornerRadius: 20))
}
