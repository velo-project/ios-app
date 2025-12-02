//
//  ForgotPasswordView.swift
//  VeloiOSApp
//
//  Created by Gabriel Araújo Lima on 02/12/25.
//

import SwiftUI

struct ForgotPasswordView: View {
    @StateObject private var viewModel = ForgotPasswordViewModel()
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
                        Text("esqueceu sua senha?")
                            .font(.title2)
                            .fontWeight(.bold)
                        Text("insira seu e-mail para\nrecuperar sua senha.")
                    }
                    VStack(spacing: 20) {
                        VStack {
                            VeloTextField(
                                text: $viewModel.email,
                                placeholder: "email",
                                icon: "envelope")
                        }
                        
                        VeloButton {
                            Text("enviar")
                        } action: {
                            if viewModel.email != "" {
                                isLoading = true
                                await viewModel.forgotPassword()
                                sheetStore.sheet = .recoveryPasswordConfirmation
                                isLoading = false
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
