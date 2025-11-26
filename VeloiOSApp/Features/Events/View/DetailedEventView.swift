//
//  DetailedEventView.swift
//  VeloiOSApp
//
//  Created by Gabriel Araújo Lima on 23/10/25.
//

import Foundation
import SwiftUI
import Kingfisher

struct DetailedEventView: View {
    @Environment(\.dismiss) var dismiss
    var event: Event
    @ObservedObject var viewModel: EventsViewModel
    
    var body: some View {
        VStack(spacing: 0) {
            ScrollView {
                VStack(alignment: .leading, spacing: 10) {
                    Spacer()
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
                        .clipShape(RoundedRectangle(cornerRadius: 20))
                        .shadow(color: .black.opacity(0.1), radius: 6, x: 0, y: 4)
                    
                    Text(event.name)
                        .font(.title).bold()
                    Text(event.description)
                    
                    HStack {
                        Image(systemName: "calendar")
                        Text(event.date)
                    }
                    
                    HStack {
                        Image(systemName: "location")
                        Text(event.location)
                    }
                }
                .padding()
            }
        }
        
        Spacer()
        
        VeloButton {
            Text(viewModel.isSubscribed(to: event) ? "cancelar inscrição" : "inscrever-se")
        } action: {
            Task {
                await viewModel.subscribe(event: event)
                dismiss()
            }
        }
        .padding()
    }
}

