//
//  TabStore.swift
//  VeloiOSApp
//
//  Created by Gabriel Araújo on 20/11/25.
//

import Foundation

class TabStore: ObservableObject {
    static let shared = TabStore()
    
    private init() { }
    
    @Published var tab: Tabs = .maps
}
