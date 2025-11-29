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
    @State private var selectedPhoto: PhotosPickerItem?
    @State private var selectedBanner: PhotosPickerItem?

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
                        Text(user.name)
                            .font(.largeTitle)
                            .fontWeight(.bold)
                        Spacer()
                    }.padding()
                    
                    Text(user.description ?? "Sem descrição.")
                        .padding()

                    HStack {
                        PhotosPicker(selection: $selectedPhoto, matching: .images) {
                            Text("Alterar Foto")
                        }
                        .onChange(of: selectedPhoto) { _, newItem in
                            Task {
                                if let data = try? await newItem?.loadTransferable(type: Data.self) {
                                    await viewModel.uploadProfilePhoto(imageData: data)
                                }
                            }
                        }

                        PhotosPicker(selection: $selectedBanner, matching: .images) {
                            Text("Alterar Banner")
                        }
                        .onChange(of: selectedBanner) { _, newItem in
                            Task {
                                if let data = try? await newItem?.loadTransferable(type: Data.self) {
                                    await viewModel.uploadBanner(imageData: data)
                                 }
                            }
                        }
                    }
                    .buttonStyle(.bordered)

                    Button("Sair da Conta") {
                        viewModel.logout()
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
        .navigationTitle("Perfil")
    }
}
