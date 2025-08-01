//
//  LoginView.swift
//  VeloiOSApp
//
//  Created by Gabriel Araújo Lima on 30/07/25.
//

import SwiftUI

struct LoginView: View {
    @StateObject var viewModel = LoginViewModel()
    
    var body: some View {
        ScrollView {
            Spacer()
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
                    
                    Button(action: {}) {
                        Text("entrar")
                    }
                    .foregroundColor(.black)
                    .frame(maxWidth: .infinity)
                    .padding(.all, 13)
                    .background(.green)
                    .cornerRadius(50)
                    .shadow(color: .black.opacity(0.1), radius: 6, x: 0, y: 4)
                }
            }
            Spacer()
        }
        .padding()
    }
}

struct LoginView_Previews: PreviewProvider {
    static var previews: some View {
        LoginView()
    }
}
