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
    var action: () async -> Void
    
    init(@ViewBuilder content: @escaping () -> Content, action: @escaping () async -> Void) {
        self.content = content
        self.action = action
    }
    
    init(@ViewBuilder content: @escaping () -> Content, action: @escaping () -> Void) {
        self.content = content
        self.action = { action() }
    }
    
    var body: some View {
        Button(action: {
            Task {
                await action()
            }
        }) {
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

extension VeloButton where Content == Text {
    init(text: String, action: @escaping () async -> Void) {
        self.init(content: { Text(text) }, action: action)
    }
    
    init(text: String, action: @escaping () -> Void) {
        self.init(content: { Text(text) }, action: action)
    }
}
