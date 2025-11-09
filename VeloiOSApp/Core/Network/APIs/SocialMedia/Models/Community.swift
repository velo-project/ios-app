//
//  Community.swift
//  VeloiOSApp
//
//  Created by Gabriel Araújo on 08/11/25.
//

import Foundation

struct Community: Decodable, Identifiable {
    let id: Int
    let name: String
    let description: String
    let embeddings: [Float]?
    let createdBy: Int
    let createdAt: Date
    let isDeleted: Bool
}
