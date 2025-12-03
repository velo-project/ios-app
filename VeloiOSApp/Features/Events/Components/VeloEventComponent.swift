//
//  VeloEventComponent.swift
//  VeloiOSApp
//
//  Created by Gabriel Araújo Lima on 22/10/25.
//

import Foundation
import SwiftUI
import Kingfisher

struct VeloEventComponent: View {
    let event: Event
    var isRightAligned: Bool = false

    var body: some View {
        if isRightAligned {
            rightAlignedView
        } else {
            defaultView
        }
    }

    @ViewBuilder
    private var defaultView: some View {
        VStack(alignment: .leading) {
            KFImage(URL(string: event.imageUrl))
                .placeholder {
                    ZStack {
                        Color.gray.opacity(0.3)
                        Image(systemName: "photo.on.rectangle.angled")
                            .font(.largeTitle)
                            .foregroundColor(.gray)
                    }
                }
                .retry(maxCount: 3, interval: .seconds(2))
                .fade(duration: 0.25)
                .resizable()
                .aspectRatio(contentMode: .fill)
                .frame(width: 240, height: 140)
                .clipShape(RoundedRectangle(cornerRadius: 20))
                .shadow(color: .black.opacity(0.1), radius: 4, x: 0, y: 3)
            
            Text(event.name)
                .font(.headline)
                .lineLimit(1)
            
            Text(event.description)
                .font(.subheadline)
                .lineLimit(2)
                .foregroundColor(.secondary)
        }
        .frame(width: 240)
    }

    @ViewBuilder
    private var rightAlignedView: some View {
        HStack(spacing: 16) {
            KFImage(URL(string: event.imageUrl))
                .placeholder {
                    ZStack {
                        Color.gray.opacity(0.3)
                        Image(systemName: "photo.on.rectangle.angled")
                            .font(.largeTitle)
                            .foregroundColor(.gray)
                    }
                }
                .retry(maxCount: 3, interval: .seconds(2))
                .fade(duration: 0.25)
                .resizable()
                .aspectRatio(contentMode: .fill)
                .frame(width: 100, height: 100)
                .clipShape(RoundedRectangle(cornerRadius: 16))
                .shadow(color: .black.opacity(0.1), radius: 4, x: 0, y: 3)
            
            VStack(alignment: .leading, spacing: 4) {
                Text(event.name)
                    .font(.headline)
                    .lineLimit(1)
                
                Text(event.description)
                    .font(.subheadline)
                    .lineLimit(2)
                    .truncationMode(.tail)
                    .foregroundColor(.secondary)
            }
        }
        .frame(width: 240, alignment: .leading)
    }
}
