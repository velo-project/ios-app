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
                    UserProfileView()
                case .editUserProfile(let user):
                    EditUserProfileView(user: user)
                case .otherUserProfile(let user):
                    OtherUserProfileView(user: user)
                }
            }
    }
}
