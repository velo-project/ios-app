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
                            await viewModel.fetchFeed()
                        }
                    }
                }
            } else {
                ScrollView {
                    VStack(alignment: .leading, spacing: 20) {
                        Picker("CommunitiesPage", selection: $viewModel.selectedPage) {
                            Text("feed").tag(0)
                            Text("comunidades").tag(1)
                            Text("amigos").tag(2)
                        }
                        .pickerStyle(.segmented)

                        // --- ÁREA DE CRIAÇÃO DE POST (APENAS NO FEED) ---
                        if viewModel.selectedPage == 0 {
                            VStack(alignment: .trailing) {
                                TextEditor(text: $viewModel.newPostContent)
                                    .frame(height: 80)
                                    .padding(8)
                                    .overlay(
                                        RoundedRectangle(cornerRadius: 8)
                                            .stroke(Color.gray.opacity(0.5), lineWidth: 1)
                                    )
                                
                                Button(action: { Task { await viewModel.createPost() } }) {
                                    if viewModel.isCreatingPost {
                                        ProgressView().padding(.horizontal, 16)
                                    } else {
                                        Text("Publicar")
                                    }
                                }
                                .padding(.vertical, 8).padding(.horizontal, 16)
                                .background(Color.accentColor).foregroundColor(.white)
                                .cornerRadius(20)
                                .disabled(viewModel.newPostContent.isEmpty || viewModel.isCreatingPost)
                                
                                if let createError = viewModel.createPostError {
                                    Text(createError).font(.caption).foregroundColor(.red).padding(.top, 4)
                                }
                            }
                            .padding(.horizontal)
                        }
                        
                        // --- SELETOR DE CONTEÚDO DA ABA ---
                        switch viewModel.selectedPage {
                        case 0:
                            // --- ABA FEED ---
                            if viewModel.posts.isEmpty && !viewModel.isLoading {
                                Text("Seu feed está vazio. Que tal criar a primeira publicação?")
                                    .foregroundColor(.gray)
                                    .padding()
                            } else {
                                ForEach(viewModel.posts) { post in
                                    VeloPostComponent(post: post, onLikeTapped: {
                                        Task { await viewModel.toggleLike(postID: post.id) }
                                    })
                                    .padding(.horizontal)
                                }
                            }
                        case 1:
                            // --- ABA COMUNIDADES ---
                            if viewModel.communities.isEmpty && !viewModel.isLoading {
                                Text("Você ainda não participa de nenhuma comunidade.")
                                    .foregroundColor(.gray)
                                    .padding()
                            } else {
                                ForEach(viewModel.communities) { community in
                                    HStack {
                                        // TODO: Adicionar imagem da comunidade quando a API retornar
                                        VStack(alignment: .leading) {
                                            Text(community.name).font(.headline)
                                            Text(community.description).font(.caption).foregroundColor(.gray).lineLimit(1)
                                        }
                                        Spacer()
                                        Image(systemName: "chevron.right").foregroundColor(.gray)
                                    }
                                    .padding()
                                    .background(Color(uiColor: .systemBackground))
                                    .cornerRadius(8)
                                    .shadow(color: .black.opacity(0.05), radius: 4, x: 0, y: 2)
                                    .padding(.horizontal)
                                }
                            }
                        case 2:
                            // --- ABA AMIGOS ---
                            if viewModel.friends.isEmpty && !viewModel.isLoading {
                                Text("Você ainda não tem amigos.")
                                    .foregroundColor(.gray)
                                    .padding()
                            } else {
                                ForEach(viewModel.friends, id: \.self) { friendNickname in
                                    HStack {
                                        Image(systemName: "person.circle.fill")
                                            .resizable()
                                            .frame(width: 36, height: 36)
                                            .foregroundColor(.gray.opacity(0.7))
                                        Text(friendNickname)
                                            .font(.headline)
                                        Spacer()
                                    }
                                    .padding()
                                    .background(Color(uiColor: .systemBackground))
                                    .cornerRadius(8)
                                    .shadow(color: .black.opacity(0.05), radius: 4, x: 0, y: 2)
                                    .padding(.horizontal)
                                }
                            }
                        default:
                            EmptyView()
                        }
                    }
                    .padding()
                }
                .refreshable {
                    await viewModel.loadDataForCurrentPage()
                }
            }
        }
        .task {
            // Carrega os dados da aba inicial (Feed) apenas uma vez
            if viewModel.posts.isEmpty {
                await viewModel.loadDataForCurrentPage()
            }
        }
        .navigationTitle("comunidades")
    }
}
