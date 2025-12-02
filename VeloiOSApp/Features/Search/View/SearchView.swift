//
//  SearchView.swift
//  VeloiOSApp
//
//  Created by Gabriel Araújo Lima on 16/08/25.
//

import SwiftUI
import GooglePlaces

struct SearchView: View {
    @StateObject private var viewModel = SearchViewModel()
    
    var onPlaceSelected: ((GMSAutocompleteSuggestion) -> Void)?
    
    var body: some View {
        NavigationStack {
            List {
                if !viewModel.events.isEmpty {
                    Section {
                        VStack(alignment: .leading) {
                            HStack {
                                Text("eventos")
                                    .font(.title2)
                                    .fontWeight(.bold)
                                Spacer()
                                Button("ver todos") {
                                    TabStore.shared.tab = .events
                                }
                                .font(.callout)
                            }
                            .padding(.horizontal)
                            
                            ScrollView(.horizontal, showsIndicators: false) {
                                HStack(spacing: 20) {
                                    ForEach(viewModel.events.prefix(5)) { event in
                                        VeloEventComponent(event: event)
                                    }
                                }
                                .padding(.horizontal)
                                .padding(.bottom)
                            }
                        }
                    }
                    .listRowInsets(EdgeInsets())
                    .listRowBackground(Color.clear)
                }

                if let errorMessage = viewModel.errorMessage {
                    Section {
                        Text(errorMessage)
                            .foregroundColor(.red)
                            .font(.caption)
                    }
                }
                
                ForEach(viewModel.suggestions, id: \.self) { suggestion in
                    
                    if let place = suggestion.placeSuggestion {
                        Button {
                            viewModel.didSelectPlace(suggestion)
                            onPlaceSelected?(suggestion)
                        } label: {
                            VStack(alignment: .leading) {
                                Text(place.attributedPrimaryText.string)
                                    .font(.headline)
                                    .foregroundColor(.primary)
                                
                                Text(place.attributedSecondaryText?.string ?? "")
                                    .font(.subheadline)
                                    .foregroundColor(.gray)
                            }
                            .padding(.vertical, 4)
                        }
                    }
                }
            }
            .listStyle(.plain)
            .navigationTitle("buscar")
            .navigationBarTitleDisplayMode(.inline)
            .searchable(text: $viewModel.query, placement: .navigationBarDrawer(displayMode: .always), prompt: "buscar endereço ou eventos")
            .overlay {
                if viewModel.suggestions.isEmpty && viewModel.events.isEmpty && !viewModel.query.isEmpty {
                    ContentUnavailableView.search(text: viewModel.query)
                }
            }
        }
    }
}


#Preview {
    SearchView()
}
