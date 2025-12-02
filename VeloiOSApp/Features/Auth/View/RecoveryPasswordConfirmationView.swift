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
    
    @State private var isLoading: Bool = false
    
    @Environment(\.dismiss) var dismiss
    
    var body: some View {
        ZStack {
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
                                await viewModel.recoveryPasswordConfirmation()
                                isLoading = false
                                dismiss()
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
            if isLoading {
                Color.black.opacity(0.5).edgesIgnoringSafeArea(.all)
                ProgressView()
            }
        }
}
