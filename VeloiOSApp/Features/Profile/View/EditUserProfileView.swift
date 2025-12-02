//
//  EditUserProfileView.swift
//  VeloiOSApp
//
//  Created by Gabriel Araújo Lima on 01/12/25.
//

import SwiftUI
import PhotosUI

struct EditUserProfileView: View {
    @StateObject private var viewModel: EditUserProfileViewModel
    @State private var selectedPhoto: PhotosPickerItem?
    @State private var selectedBanner: PhotosPickerItem?
    @Environment(\.dismiss) var dismiss

    init(user: User) {
        _viewModel = StateObject(wrappedValue: EditUserProfileViewModel(user: user))
    }

    var body: some View {
        ScrollView {
            VStack {
                if viewModel.isLoading {
                    ProgressView()
                } else if let user = viewModel.user {
                    ZStack(alignment: .bottomLeading) {
                        PhotosPicker(selection: $selectedBanner, matching: .images) {
                            AsyncImage(url: URL(string: user.bannerPhotoUrl ?? "")) { image in
                                image.resizable()
                            } placeholder: {
                                Color.gray.opacity(0.3)
                            }
                            .frame(height: 200)
                        }
                        .onChange(of: selectedBanner) { _, newItem in
                            Task {
                                if let data = try? await newItem?.loadTransferable(type: Data.self) {
                                    if let image = UIImage(data: data) {
                                        await viewModel.uploadBanner(image: image)
                                    }
                                }
                            }
                        }

                        PhotosPicker(selection: $selectedPhoto, matching: .images) {
                            AsyncImage(url: URL(string: user.profilePhotoUrl ?? "")) { image in
                                image.resizable()
                            } placeholder: {
                                Color.gray
                            }
                            .frame(width: 100, height: 100)
                            .clipShape(Circle())
                            .overlay(Circle().stroke(Color.white, lineWidth: 4))
                        }
                        .onChange(of: selectedPhoto) { _, newItem in
                            Task {
                                if let data = try? await newItem?.loadTransferable(type: Data.self) {
                                    if let image = UIImage(data: data) {
                                        await viewModel.uploadProfilePhoto(image: image)
                                    }
                                }
                            }
                        }
                        .offset(x: 15, y: 50)
                    }
                    .frame(height: 250)

                    VStack(alignment: .leading) {
                        Text("Nickname")
                            .font(.headline)
                        TextField("Nickname", text: $viewModel.nickname)
                            .textFieldStyle(RoundedBorderTextFieldStyle())
                    }
                    .padding()

                    VStack(alignment: .leading) {
                        Text("Nome")
                            .font(.headline)
                        TextField("Nome", text: $viewModel.name)
                            .textFieldStyle(RoundedBorderTextFieldStyle())
                    }
                    .padding()
                    
                    VStack(alignment: .leading) {
                        Text("Descrição")
                            .font(.headline)
                        TextEditor(text: $viewModel.description)
                            .frame(height: 100)
                            .overlay(RoundedRectangle(cornerRadius: 8).stroke(Color.gray, lineWidth: 1))
                    }
                    .padding()

                    VeloButton(text: "Salvar", action: {
                        Task {
                            await viewModel.saveProfile()
                        }
                    })
                    .padding()
                }
            }
        }
        .navigationTitle("Editar Perfil")
        .alert("Erro", isPresented: $viewModel.showErrorAlert) {
            Button("OK", role: .cancel) { }
        } message: {
            Text(viewModel.errorMessage)
        }
        .alert("Sucesso", isPresented: $viewModel.showSuccessAlert) {
            Button("OK", role: .cancel) {
                dismiss()
            }
        } message: {
            Text(viewModel.successMessage)
        }
    }
}
