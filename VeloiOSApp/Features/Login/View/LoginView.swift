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
        VStack {
            Spacer()
            VStack(alignment: .leading, spacing: 50) {
                VStack(alignment: .leading) {
                    Text("bem vindo.")
                        .font(.title2)
                        .bold()
                    Text("insira suas credenciais\npara entrar.")
                }
                VStack(spacing: 20) {
                    VStack {
                        HStack {
                            TextField("email", text: $viewModel.email)
                                .autocorrectionDisabled(true)
                                .textInputAutocapitalization(.never)
                            Image(systemName: "envelope")
                        }
                        .padding(.all, 13)
                        .padding(.horizontal, 7)
                        .background(.white)
                        .cornerRadius(50)
                        .shadow(color: .black.opacity(0.1), radius: 6, x: 0, y: 4)
                        
                        HStack {
                            SecureField("senha", text: $viewModel.password)
                                .autocorrectionDisabled(true)
                                .textInputAutocapitalization(.never)
                            Image(systemName: "lock")
                        }
                        .padding(.all, 13)
                        .padding(.horizontal, 7)
                        .background(.white)
                        .cornerRadius(50)
                        .shadow(color: .black.opacity(0.1), radius: 6, x: 0, y: 4)
                        
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
