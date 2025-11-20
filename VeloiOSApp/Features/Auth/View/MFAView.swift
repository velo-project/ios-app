//
//  MFAView.swift
//  VeloiOSApp
//
//  Created by Gabriel Araújo on 09/11/25.
//

import Foundation
import SwiftUI

struct MFAView: View {
    @Environment(\.dismiss) var dimiss
    
    @Binding var code: String
    @Binding var isLoading: Bool
    
    private let authService = AuthService()
    private let tabStore = TabStore.shared
    
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
                    Text("código de confirmação")
                        .font(.title2)
                        .fontWeight(.bold)
                    Text("confirme se é você\nmesmo estrando.")
                }
                VStack(spacing: 20) {
                    VStack {
                        VeloTextField(
                            text: $code,
                            placeholder: "digite aqui",
                            icon: "key")
                    }
                    
                    VeloButton {
                        Text("entrar")
                    } action: {
                        if !code.isEmpty {
                            do {
                                isLoading = true
                                let success = try await authService.verifyCode(code: code)
                                if success {
                                    tabStore.tab = .maps
                                    dimiss()
                                }
                                isLoading = false
                            } catch {
                                isLoading = false
                                tabStore.tab = .maps
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
