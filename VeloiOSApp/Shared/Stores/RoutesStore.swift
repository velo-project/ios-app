//
//  RoutesStore.swift
//  VeloiOSApp
//
//  Created by Gabriel Araújo on 21/11/25.
//
 
import Foundation

class RoutesStore: ObservableObject {
    static let shared = RoutesStore()
    
    private init() { }
    
    @Published var routes: [Route] = []
}
