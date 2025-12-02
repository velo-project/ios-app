//
//  FeedResponse.swift
//  VeloiOSApp
//
//  Created by Gabriel Araújo on 02/12/25.
//

import Foundation

struct FeedResponse: Decodable {
    var statusCode: Int
    var message: String?
    var feed: [Feed]
    var timestamp: String
}
