//
//  LoginView.swift
//  VeloiOSApp
//
//  Created by Gabriel Araújo Lima on 30/07/25.
//

import SwiftUI

struct LoginView: View {
    @StateObject private var viewModel = LoginViewModel()
    
    @Binding var activePage: SheetStep?
    @Binding var isLoading: Bool
    
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
                    Text("bem vindo.")
                        .font(.title2)
                        .fontWeight(.bold)
                    Text("insira suas credenciais\npara entrar.")
                }
                VStack(spacing: 20) {
                    VStack {
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
                    
                    HStack {
                        Spacer()
                        Text("esqueci a senha")
                    }
                    .frame(maxWidth: .infinity)
                    
                    VeloButton {
                        Text("entrar")
                    } action: {
                        if viewModel.email != "" && viewModel.password != "" {
                            isLoading = true
                            
                            // mock trying to fetch api data
                            DispatchQueue.main.asyncAfter(deadline: .now() + 5) {
                                activePage = .mfa
                            }
                        }
                    }
                }
            }
            .padding()
            Spacer()
        }
    }
}
