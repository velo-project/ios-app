//
//  PostResponseModel.swift
//  VeloiOSApp
//
//  Created by Gabriel Araújo Lima on 01/10/25.
//

import Foundation

struct PostResponseModel: Identifiable {
    let id: Int
    let content: String
    let hashtags: String
    let postedBy: String     // Nome formatado
    let postedById: Int      // ID para navegação futura
    let postedAt: String
    let postedIn: String     // Nome da comunidade
    let profileImage: String
    let imageUrl: String?    // Foto do post, se tiver
    
    // Propriedades mutáveis para a UI reagir instantaneamente
    var likesCount: Int
    var isLikedByMe: Bool
}
