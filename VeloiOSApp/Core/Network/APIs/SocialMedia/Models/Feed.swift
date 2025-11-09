//
//  FeedModel.swift
//  VeloiOSApp
//
//  Created by Gabriel Araújo on 08/11/25.
//

import Foundation

struct Feed: Identifiable, Decodable {
    let id: Int
    let content: String
    let imageUrl: String?
    let hashtags: [Hashtag]
    let postedAt: Date
    let postedBy: Int
    let postedIn: Community
    let isDeleted: Bool

    enum CodingKeys: String, CodingKey {
        case id
        case content
        case imageUrl
        case hashtags
        case postedAt
        case postedBy
        case postedIn
        case isDeleted
    }
}

