//
//  GetUserCommunitiesQueryResult.swift
//  VeloiOSApp
//
//  Created by Gabriel Araújo on 03/12/25.
//

import Foundation

struct GetUserCommunitiesQueryResult: Decodable {
    let communityIds: [Int]
    let statusCode: Int
    let message: String
    let timestamp: String
}
