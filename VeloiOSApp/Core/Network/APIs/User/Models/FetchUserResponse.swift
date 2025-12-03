//
//  FetchUserResponse.swift
//  VeloiOSApp
//
//  Created by Gabriel Araújo on 29/11/25.
//

import Foundation

struct FetchUserResponse: Codable {
    var message: String
    var user: User
    var statusCode: Int
    var timestamp: String
}
