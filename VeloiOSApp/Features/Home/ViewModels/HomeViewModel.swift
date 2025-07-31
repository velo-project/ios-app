//
//  HomeViewModel.swift
//  VeloiOSApp
//
//  Created by Gabriel Araújo Lima on 31/07/25.
//

import Foundation

class HomeViewModel: ObservableObject {
    @Published var searchQuery: String = ""
    @Published var selectedButton: Int = 1
    
    func changeSelectedButton(button: Int) {
        selectedButton = button
    }
}
