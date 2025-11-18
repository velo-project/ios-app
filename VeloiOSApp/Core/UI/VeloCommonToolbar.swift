//
//  VeloCommonToolbar.swift
//  VeloiOSApp
//
//  Created by Gabriel Araújo on 11/11/25.
//

import Foundation
import SwiftUI

struct VeloCommonToolbar: ViewModifier {
    let action: () -> Void
    
    func body(content: Content) -> some View {
        content.toolbar {
                ToolbarItem(placement: .topBarTrailing) {
                    Button {
                        action()
                    } label: {
                        Image(systemName: "person")
                    }
                }
            }
    }
}

extension View {
    func veloCommonToolbar(action: @escaping () -> Void) -> some View {
        self.modifier(VeloCommonToolbar(action: action))
    }
}
