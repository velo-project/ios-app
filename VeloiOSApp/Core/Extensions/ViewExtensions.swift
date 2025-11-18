//
//  ViewExtensions.swift
//  VeloiOSApp
//
//  Created by Gabriel Araújo on 18/11/25.
//

import Foundation
import SwiftUI

extension View {
    @ViewBuilder
    func veloUserProfileNavigation() -> some View {
        self
            .navigationDestination(for: ViewDestination.self) { destination in
                switch destination {
                case .userProfile:
                    VStack {
                        Text("Oiii da tela de usuário")
                    }
                }
            }
    }
}
