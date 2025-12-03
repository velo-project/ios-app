//
//  LoginTokenResponse.swift
//  VeloiOSApp
//
//  Created by Gabriel Araújo on 09/11/25.
//

struct LoginTokenResponse: Codable {
    let accessToken: String
    let expiresIn: Int
}
