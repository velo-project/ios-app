//
//  VeloTextField.swift
//  VeloiOSApp
//
//  Created by Gabriel Araújo Lima on 31/07/25.
//

import SwiftUI

struct VeloTextField: View {
    @Binding var text: String
    
    var placeholder: String
    var icon: String
    var isSecure: Bool = false
    
    var body: some View {
        HStack {
            getTextView()
                .autocorrectionDisabled(true)
                .textInputAutocapitalization(.never)
            Image(systemName: icon)
        }
        .padding(.all, 13)
        .padding(.horizontal, 7)
        .background(.white)
        .cornerRadius(50)
        .shadow(color: .black.opacity(0.1), radius: 6, x: 0, y: 4)
    }
    
    @ViewBuilder
    private func getTextView() -> some View {
        if !isSecure {
            TextField(placeholder, text: $text)
        } else {
            SecureField(placeholder, text: $text)
        }
    }
}

struct VeloTextField_Previews: PreviewProvider {
    struct PreviewWrapper: View {
        @State private var text = ""
        
        var body: some View {
            VeloTextField(
                text: $text,
                placeholder: "digite aqui",
                icon: "envelope")
        }
    }
    
    
    static var previews: some View {
        PreviewWrapper()
    }
}
