//
//  UsersLiked.swift
//  VeloiOSApp
//
//  Created by Gabriel Araújo on 08/11/25.
//

import Foundation

struct UsersLiked: Identifiable, Decodable {
    var id = UUID()
    var postId: Int
    var likedBy: Int
    var likedAt: Date
}
