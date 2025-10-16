//
//  PostResponseModel.swift
//  VeloiOSApp
//
//  Created by Gabriel Araújo Lima on 01/10/25.
//

import Foundation

struct PostResponseModel: Identifiable {
    var id = UUID()
    var content: String
    var hashtags: String
    var postedBy: String
    var postedAt: Date
    var postedIn: String
}
