//
//  VeloCommonToolbar.swift
//  VeloiOSApp
//
//  Created by Gabriel Araújo on 11/11/25.
//

import Foundation
import SwiftUI

struct VeloCommonToolbar: ViewModifier {
    
    func body(content: Content) -> some View {
        content
            .toolbar {
                ToolbarItem(placement: .topBarTrailing) {
                    Button {
                        print("hi")
                    } label: {
                        Image(systemName: "person")
                    }
                }
            }
    }
    
}

extension View {
    func veloCommonToolbar() -> some View {
        self.modifier(VeloCommonToolbar())
    }
}
