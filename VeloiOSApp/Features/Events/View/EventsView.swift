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
        VStack {
            ScrollView {
                VStack(alignment: .leading, spacing: 32) {
                    VStack(alignment: .leading, spacing: 16) {
                        Text("eventos inscritos")
                            .font(.title2)
                            .fontWeight(.bold)
                            .padding(.horizontal)
                        
                        if !viewModel.subscribedEvents.isEmpty {
                            ScrollView(.horizontal, showsIndicators: false) {
                                HStack(spacing: 16) {
                                    ForEach(viewModel.subscribedEvents) { event in
                                        VeloEventCodeComponent(event: event)
                                    }
                                }
                                .padding(.horizontal)
                            }
                        } else {
                            Text("nenhum evento encontrado!")
                                .frame(maxWidth: .infinity, alignment: .leading)
                                .padding(.horizontal)
                        }
                    }
                    
                    VStack(alignment: .leading, spacing: 16) {
                        Text("para você")
                            .font(.title2)
                            .fontWeight(.bold)
                            .padding(.horizontal)
                        
                        if !viewModel.recommendedEvents.isEmpty {
                            ScrollView(.horizontal, showsIndicators: false) {
                                HStack(spacing: 16) {
                                    ForEach(viewModel.recommendedEvents) { event in
                                        VeloEventComponent(event: event)
                                            .frame(width: 280)
                                            .onTapGesture {
                                                viewModel.selectedEvent = event
                                            }
                                    }
                                }
                                .padding(.horizontal)
                            }
                        } else {
                            Text("nenhum evento encontrado!")
                                .frame(maxWidth: .infinity, alignment: .leading)
                                .padding(.horizontal)
                        }
                    }
                    
                    VStack(alignment: .leading, spacing: 16) {
                        Text("em alta")
                            .font(.title2)
                            .fontWeight(.bold)
                            .padding(.horizontal)
                        
                        if !viewModel.trendingEvents.isEmpty {
                            ScrollView(.horizontal, showsIndicators: false) {
                                HStack(spacing: 16) {
                                    ForEach(viewModel.trendingEvents) { event in
                                        VeloEventComponent(event: event)
                                            .frame(width: 280)
                                            .onTapGesture {
                                                viewModel.selectedEvent = event
                                            }
                                    }
                                }
                                .padding(.horizontal)
                            }
                        } else {
                            Text("nenhum evento encontrado!")
                                .frame(maxWidth: .infinity, alignment: .leading)
                                .padding(.horizontal)
                        }
                    }
                    
                    VStack(alignment: .leading, spacing: 16) {
                        Text("últimos participados")
                            .font(.title2)
                            .fontWeight(.bold)
                            .padding(.horizontal)
                        
                        if !viewModel.lastParticipatedEvents.isEmpty {
                            ScrollView(.horizontal, showsIndicators: false) {
                                HStack(spacing: 16) {
                                    ForEach(viewModel.lastParticipatedEvents) { event in
                                        VeloEventComponent(event: event)
                                            .frame(width: 280)
                                            .onTapGesture {
                                                viewModel.selectedEvent = event
                                            }
                                    }
                                }
                                .padding(.horizontal)
                            }
                        } else {
                            Text("nenhum evento encontrado!")
                                .frame(maxWidth: .infinity, alignment: .leading)
                                .padding(.horizontal)
                        }
                    }
                }
                .padding(.vertical, 8)
            }
            .sheet(item: $viewModel.selectedEvent) { event in
                DetailedEventView(event: event, viewModel: viewModel)
            }
        }
        .navigationTitle("eventos")
        .onAppear {
            Task {
                await viewModel.loadEvents()
            }
        }
    }
}
