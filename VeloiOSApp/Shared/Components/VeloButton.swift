//
//  VeloButton.swift
//  VeloiOSApp
//
//  Created by Gabriel Araújo Lima on 24/10/25.
//

import Foundation
import SwiftUI

struct VeloButton<Content: View>: View {
    var content: () -> Content
    var action: () -> Void
    
    var body: some View {
        Button(action: action) {
            content()
                .foregroundStyle(.black)
                .bold()
                .frame(maxWidth: .infinity)
                .padding()
                .background(.green)
                .clipShape(RoundedRectangle(cornerRadius: 50))
                .shadow(color: .black.opacity(0.1), radius: 6, x: 0, y: 4)
        }
        .buttonStyle(.plain)
    }
}
