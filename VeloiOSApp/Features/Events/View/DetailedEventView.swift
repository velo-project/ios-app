//
//  DetailedEventView.swift
//  VeloiOSApp
//
//  Created by Gabriel Araújo Lima on 23/10/25.
//

import Foundation
import SwiftUI

struct DetailedEventView: View {
    @Environment(\.dismiss) var dimiss
    var event: BrandEventsModel
    
    var body: some View {
        VStack(spacing: 0) {
            ScrollView {
                VStack(alignment: .leading, spacing: 10) {
                    Spacer()
                    AsyncImage(url: URL(string: event.imageUrl)) { phase in
                        switch phase {
                        case .empty:
                            ZStack {
                                Color.gray.opacity(0.3)
                                ProgressView()
                            }
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
                        @unknown default:
                            EmptyView()
                        }
                    }
                    .clipShape(RoundedRectangle(cornerRadius: 20))
                    .shadow(color: .black.opacity(0.1), radius: 6, x: 0, y: 4)
                    
                    Text(event.title)
                        .font(.title).bold()
                    Text(event.description)
                }
                .padding()
            }
        }
        
        Spacer()
        
        VeloButton {
            Text("inscrever-se")
        } action: {
            dimiss()
        }
        .padding()
    }
}

