//
//  Follower.swift
//  VeloiOSApp
//
//  Created by Gabriel Araújo on 08/11/25.
//

import Foundation

struct Follower: Decodable, Identifiable {
    var id = UUID()
    var userId: Int
    var followerId: Int
    var followerAt: Date
}
