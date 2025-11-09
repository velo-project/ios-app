//
//  User.swift
//  VeloiOSApp
//
//  Created by Gabriel Araújo on 09/11/25.
//

struct User: Codable {
    let id: Int
    let name: String
    let email: String
    let nickname: String
    let bannerPhotoUrl: String?
    let profilePhotoUrl: String?
    let description: String?
    let isBlocked: Bool
    let isDeleted: Bool
    let registeredAt: String
    let roles: [Role]
}
