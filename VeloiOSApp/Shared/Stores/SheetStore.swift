//
//  SheetStore.swift
//  VeloiOSApp
//
//  Created by Gabriel Araújo on 20/11/25.
//

import Foundation

class SheetStore: ObservableObject {
    static let shared = SheetStore()
    
    private init() { }
    
    @Published var sheet: Sheets? = nil
}
