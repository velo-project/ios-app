//
//  LoginView.swift
//  VeloiOSApp
//
//  Created by Gabriel Araújo Lima on 30/07/25.
//

import SwiftUI

struct LoginView: View {
    @Environment(\.dismiss) var dimiss
    @StateObject private var viewModel = LoginViewModel()
    
    @Binding var selectedTab: Int
    
    var body: some View {
        ScrollView {
            VStack(alignment: .leading, spacing: 50) {
                Image("AppLogo")
                    .resizable()
                    .aspectRatio(contentMode: .fit)
                    .frame(height: 80)
                    .padding(.horizontal, .none)
                    .padding(.vertical, 20)
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
//                        let token = viewModel.login()
//                        if (token.isAuthenticated) {
//                            selectedTab = 1
//                            dimiss()
//                        }
                    }
                }
            }
            .padding()
            Spacer()
        }
    }
}

//#Preview {
//    LoginView()
//}
