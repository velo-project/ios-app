//
//  GetCommunityByIdResponse.swift
//  VeloiOSApp
//
//  Created by Gabriel Araújo on 03/12/25.
//

import Foundation

struct GetCommunityByIdResponse: Decodable {
    let message: String
    let timestamp: String
    let statusCode: Int
    let community: Community?
}
