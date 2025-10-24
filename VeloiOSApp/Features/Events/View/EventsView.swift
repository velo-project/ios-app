//
//  EventsView.swift
//  VeloiOSApp
//
//  Created by Gabriel Araújo Lima on 22/10/25.
//

import Foundation
import SwiftUI

struct EventsView: View {
    @StateObject private var viewModel = EventsViewModel()
     
    var body: some View {
        ScrollView {
            VStack(alignment: .leading, spacing: 24) {
                
                VStack(alignment: .leading, spacing: 8) {
                    Text("para você")
                        .font(.title2)
                        .fontWeight(.bold)
                        .padding(.horizontal)

                    ScrollView(.horizontal, showsIndicators: false) {
                        HStack(spacing: 16) {
                            ForEach(viewModel.forYouEvents) { event in
                                VeloEventComponent(event: event)
                                    .onTapGesture {
                                        viewModel.selectedEvent = event
                                    }
                            }
                        }
                        .padding(.horizontal)
                    }
                }
                
                VStack(alignment: .leading, spacing: 8) {
                    Text("em alta")
                        .font(.title2)
                        .fontWeight(.bold)
                        .padding(.horizontal)

                    ScrollView(.horizontal, showsIndicators: false) {
                        HStack(spacing: 16) {
                             ForEach(viewModel.trendingEvents) { event in
                                VeloEventComponent(event: event)
                                     .onTapGesture {
                                         viewModel.selectedEvent = event
                                     }
                            }
                        }
                        .padding(.horizontal)
                    }
                }
                
                VStack(alignment: .leading, spacing: 8) {
                    Text("últimos participados")
                        .font(.title2)
                        .fontWeight(.bold)
                        .padding(.horizontal)

                    ScrollView(.horizontal, showsIndicators: false) {
                        HStack(spacing: 16) {
                            ForEach(viewModel.lastKnowEvents) { event in
                                VeloEventComponent(event: event)
                                    .onTapGesture {
                                        viewModel.selectedEvent = event
                                    }
                            }
                        }
                        .padding(.horizontal)
                    }
                }
            }
        }
        .sheet(item: $viewModel.selectedEvent) { event in
            DetailedEventView(event: event)
        }
    }
}
