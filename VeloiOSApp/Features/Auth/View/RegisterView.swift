//
//  RegisterView.swift
//  VeloiOSApp
//
//  Created by Gabriel Araújo Lima on 26/11/25.
//

import SwiftUI

struct RegisterView: View {
    @StateObject private var viewModel = RegisterViewModel()
    @StateObject private var sheetStore = SheetStore.shared
    
    @Binding var isLoading: Bool
    
    @Environment(\.dismiss) var dismiss
    
    var body: some View {
        ScrollView {
            VStack(alignment: .leading, spacing: 50) {
                Image("AppLogo")
                    .resizable()
                    .aspectRatio(contentMode: .fit)
                    .frame(height: 80)
                    .padding(.horizontal, .none)
                    .padding(.top, 50)
                VStack(alignment: .leading) {
                    Text("crie sua conta.")
                        .font(.title2)
                        .fontWeight(.bold)
                    Text("insira seus dados\npara se cadastrar.")
                }
                VStack(spacing: 20) {
                    VStack {
                        VeloTextField(
                            text: $viewModel.name,
                            placeholder: "nome",
                            icon: "person")
                        
                        VeloTextField(
                            text: $viewModel.nickname,
                            placeholder: "nickname",
                            icon: "person.text.rectangle")
                        
                        VeloTextField(
                            text: $viewModel.email,
                            placeholder: "email",
                            icon: "envelope")
                        
                        VeloTextField(
                            text: $viewModel.password,
                            placeholder: "senha",
                            icon: "lock",
                            isSecure: true)
                    }
                    
                    VeloButton {
                        Text("cadastrar")
                    } action: {
                        if viewModel.email != "" && viewModel.password != "" {
                            isLoading = true
                            dismiss()
                            Task {
                                await viewModel.register()
                                sheetStore.sheet = .mfa
                            }
                        }
                    }
                }
            }
            .padding()
            Spacer()
        }
        .onAppear {
            isLoading = false
        }
    }
}
