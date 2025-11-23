//
//  CommunitiesView.swift
//  VeloiOSApp
//
//  Created by Gabriel Araújo Lima on 01/10/25.
//

import SwiftUI

struct CommunitiesView: View {
    @StateObject private var viewModel = CommunitiesViewModel()
    
    var body: some View {
        ZStack {
            if viewModel.isLoading && viewModel.posts.isEmpty {
                ProgressView("Carregando...")
            } else if let errorMessage = viewModel.errorMessage {
                VStack {
                    Text(errorMessage)
                        .foregroundColor(.red)
                    Button("Tentar Novamente") {
                        Task {
                            await viewModel.fetchPosts()
                        }
                    }
                }
            } else {
                ScrollView {
                    VStack(alignment: .leading, spacing: 20) {
                        // TODO: Implementar a seção "Suas Comunidades"
                        Text("atividades Recentes")
                            .bold()
                            .font(.title2)
                            .padding(.horizontal)
                        
                                            ForEach(viewModel.posts) { post in
                                                VeloPostComponent(post: post)
                                                    .padding(.horizontal)
                                            }                    }
                    .padding(.vertical)
                }
                .refreshable {
                    await viewModel.fetchPosts()
                }
            }
        }
        .task {
            if viewModel.posts.isEmpty {
                await viewModel.fetchPosts()
            }
        }
        .navigationTitle("comunidades")
    }
}
