//
//  Member.swift
//  VeloiOSApp
//
//  Created by Gabriel Araújo on 08/11/25.
//

import Foundation

struct Member: Identifiable, Decodable {
    var id: Int
    var name: String
    var nickname: String
    var bannerPhotoUrl: String
    var isBlocked: Bool
    var isDeleted: Bool
}
