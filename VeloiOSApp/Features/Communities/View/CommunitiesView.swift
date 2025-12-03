//
//  CommunitiesView.swift
//  VeloiOSApp
//
//  Created by Gabriel Araújo Lima on 01/10/25.
//

import SwiftUI

struct CommunitiesView: View {
    @StateObject private var viewModel = CommunitiesViewModel()
    @FocusState private var isTextEditorFocused: Bool
    
    var body: some View {
        VStack(alignment: .leading) {
            Picker("CommunitiesPage", selection: $viewModel.selectedPage) {
                Text("feed").tag(0)
//                Text("comunidades").tag(1)
                Text("amigos").tag(2)
            }
            .pickerStyle(.segmented)
            .padding(.horizontal)

            if viewModel.selectedPage == 0 {
                VStack(alignment: .trailing) {
                    TextEditor(text: $viewModel.newPostContent)
                        .frame(height: 80)
                        .padding(8)
                        .overlay(
                            RoundedRectangle(cornerRadius: 8)
                                .stroke(Color.gray.opacity(0.5), lineWidth: 1)
                        )
                        .focused($isTextEditorFocused)
                    
                    Button(action: {
                        Task {
                            await viewModel.createPost()
                            isTextEditorFocused = false // Dismiss keyboard
                        }
                    }) {
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

            if viewModel.isLoading && viewModel.posts.isEmpty {
                Spacer()
                ProgressView("Carregando...")
                    .frame(maxWidth: .infinity, alignment: .center)
                Spacer()
            } else {
                ScrollView {
                    LazyVStack(spacing: 20) {
                        switch viewModel.selectedPage {
                        case 0:
                            if viewModel.posts.isEmpty && !viewModel.isLoading {
                                VStack {
                                    Spacer()
                                    VStack(alignment: .center, spacing: 8) {
                                        Text("seu feed está vazio").bold()
                                        Text("que tal criar a primeira publicação?")
                                            .multilineTextAlignment(.center)
                                    }
                                    .frame(maxWidth: .infinity, maxHeight: .infinity)
                                    Spacer()
                                }
                                .padding()
                            } else {
                                ForEach(viewModel.posts) { post in
                                    VeloPostComponent(post: post, onLikeTapped: {
                                        Task { await viewModel.toggleLike(postID: post.id) }
                                    })
                                }
                            }
                        case 1:
                            if viewModel.communities.isEmpty && !viewModel.isLoading {
                                VStack {
                                    Spacer()
                                    VStack(alignment: .center, spacing: 8) {
                                        Text("você não participa de nenhuma comunidade").bold()
                                        Text("procure por comunidades e junte-se a elas!")
                                            .multilineTextAlignment(.center)
                                    }
                                    .frame(maxWidth: .infinity, maxHeight: .infinity)
                                    Spacer()
                                }
                                .padding()
                            } else {
                                ForEach(viewModel.communities) { community in
                                    HStack {
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
                                }
                            }
                        case 2:
                            if viewModel.friends.isEmpty && !viewModel.isLoading {
                                VStack {
                                    Spacer()
                                    VStack(alignment: .center, spacing: 8) {
                                        Text("você não tem amigos").bold()
                                        Text("procure por amigos e siga-os!")
                                            .multilineTextAlignment(.center)
                                    }
                                    .frame(maxWidth: .infinity, maxHeight: .infinity)
                                    Spacer()
                                }
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
                                }
                            }
                        default:
                            EmptyView()
                        }
                    }
                    .padding()
                }
                .onTapGesture {
                    isTextEditorFocused = false
                }
                .refreshable {
                    await viewModel.loadDataForCurrentPage()
                }
            }
        }
        .task {
            if viewModel.posts.isEmpty {
                await viewModel.loadDataForCurrentPage()
            }
        }
        .alert("Ops!", isPresented: Binding<Bool>(
            get: { viewModel.errorMessage != nil },
            set: { _,_ in viewModel.errorMessage = nil }
        )) {
            Button("OK", role: .cancel) { }
        } message: {
            Text(viewModel.errorMessage ?? "Erro desconhecido")
        }
        .navigationTitle("comunidades")
    }}
