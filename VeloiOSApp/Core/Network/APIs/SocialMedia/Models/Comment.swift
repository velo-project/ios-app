//
//  Comment.swift
//  VeloiOSApp
//
//  Created by Gabriel Araújo on 08/11/25.
//

import Foundation

struct Comment: Identifiable, Decodable {
    var id: Int
    var postId: Int
    var commentedBy: Int
    var content: String
    var commentedAt: Date
    var isDeleted: Bool
}
