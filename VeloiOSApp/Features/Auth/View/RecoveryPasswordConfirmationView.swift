//
//  RecoveryPasswordConfirmationView.swift
//  VeloiOSApp
//
//  Created by Gabriel Araújo Lima on 02/12/25.
//

import SwiftUI

struct RecoveryPasswordConfirmationView: View {
    @StateObject private var viewModel = RecoveryPasswordConfirmationViewModel()
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
                    Text("crie uma nova senha")
                        .font(.title2)
                        .fontWeight(.bold)
                    Text("insira o código enviado para o seu e-mail e crie uma nova senha.")
                }
                VStack(spacing: 20) {
                    VStack {
                        VeloTextField(
                            text: $viewModel.code,
                            placeholder: "código",
                            icon: "number")
                        
                        VeloTextField(
                            text: $viewModel.password,
                            placeholder: "nova senha",
                            icon: "lock",
                            isSecure: true)
                    }
                    
                    VeloButton {
                        Text("salvar")
                    } action: {
                        if viewModel.code != "" && viewModel.password != "" {
                            isLoading = true
                            dismiss()
                            await viewModel.recoveryPasswordConfirmation()
                        }
                    }
                    
                    Button(action: {
                        dismiss()
                        sheetStore.sheet = .login
                    }) {
                        Text("Lembrou a senha? Faça login")
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
