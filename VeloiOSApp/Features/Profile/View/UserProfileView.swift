//
//  UserProfileView.swift
//  VeloiOSApp
//
//  Created by Gabriel Araújo Lima on 26/11/25.
//

import SwiftUI
import PhotosUI

struct UserProfileView: View {
    @StateObject private var viewModel = UserProfileViewModel()
    @Environment(\.dismiss) var dismiss

    var body: some View {
        ScrollView {
            VStack {
                if viewModel.isLoading {
                    ProgressView()
                } else if let user = viewModel.user {
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
                        NavigationLink(value: ViewDestination.editUserProfile(user: user)) {
                            Image(systemName: "pencil")
                                .foregroundStyle(.black)
                                .bold()
                                .padding()
                                .background(.green)
                                .clipShape(RoundedRectangle(cornerRadius: 50))
                                .shadow(color: .black.opacity(0.1), radius: 6, x: 0, y: 4)
                        }
                        .buttonStyle(.plain)
                    }.padding()
                    
                    Text(user.description ?? "Sem descrição")
                        .padding()
                        .frame(maxWidth: .infinity, alignment: .leading)

                    Button("Sair da Conta") {
                        viewModel.logout()
                        dismiss()
                    }
                    .foregroundColor(.red)
                    .padding()

                    Spacer()
                } else {
                    // Fallback or error message if not loading and user is nil
                    Text("No user data available.")
                }
            }
        }
        .onAppear {
            Task {
                await viewModel.fetchUser()
            }
        }
        .navigationTitle("perfil")
    }
}
