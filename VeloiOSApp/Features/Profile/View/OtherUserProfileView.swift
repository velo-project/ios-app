//
//  OtherUserProfileView.swift
//  VeloiOSApp
//
//  Created by Gabriel Araújo on 03/12/25.
//

import SwiftUI

struct OtherUserProfileView: View {
    let user: User
    @StateObject private var viewModel = OtherUserProfileViewModel()
    @State private var isFollowing = false // TODO: Get initial follow state
    
    var body: some View {
        ScrollView {
            VStack {
                ZStack(alignment: .bottomLeading) {
                    AsyncImage(url: URL(string: user.bannerPhotoUrl ?? "")) { image in
                        image.resizable()
                    } placeholder: {
                        Color.gray.opacity(0.3)
                    }
                    .frame(height: 200)

                    AsyncImage(url: URL(string: user.profilePhotoUrl ?? "")) { image in
                        image.resizable()
                    } placeholder: {
                        Color.gray
                    }
                    .frame(width: 100, height: 100)
                    .clipShape(Circle())
                    .overlay(Circle().stroke(Color.white, lineWidth: 4))
                    .offset(x: 15, y: 50)
                }
                .frame(height: 250)

                HStack {
                    VStack(alignment: .leading) {
                        Text(user.name)
                            .font(.largeTitle)
                            .fontWeight(.bold)
                        Text("@\(user.nickname)")
                            .font(.subheadline)
                            .foregroundColor(.gray)
                    }
                    Spacer()
                    Button(action: {
                        Task {
                            if isFollowing {
                                await viewModel.unfollow(user: user)
                            } else {
                                await viewModel.follow(user: user)
                            }
                            isFollowing.toggle()
                        }
                    }) {
                        Text(isFollowing ? "Deixar de Seguir" : "Seguir")
                            .padding(.horizontal)
                            .padding(.vertical, 8)
                            .background(isFollowing ? Color.gray : Color.accentColor)
                            .foregroundColor(.white)
                            .cornerRadius(20)
                    }
                }.padding()
                
                Text(user.description ?? "sem descrição")
                    .padding()
                    .frame(maxWidth: .infinity, alignment: .leading)

                Divider()

                if viewModel.isLoading {
                    ProgressView()
                } else if let errorMessage = viewModel.errorMessage {
                    Text(errorMessage)
                        .foregroundColor(.red)
                } else {
                    LazyVStack {
                        ForEach(viewModel.posts) { post in
                            VeloPostComponent(post: post, onLikeTapped: {
                                // TODO: Handle like tapped
                            })
                            .padding(.horizontal)
                        }
                    }
                }
                
                Spacer()
            }
        }
        .navigationBarTitleDisplayMode(.inline)
        .ignoresSafeArea(.container, edges: .top)
        .task {
            await viewModel.fetchPosts(for: user)
        }
    }
}
