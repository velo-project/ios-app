//
//  RefreshTokenResponse.swift
//  VeloiOSApp
//
//  Created by Gabriel Araújo on 22/11/25.
//

import Foundation

struct RefreshTokenResponse: Decodable {
    var statusCode: Int
    var message: String
    var timestamp: Date
    var refreshToken: String
    var expiresIn: Double
}
