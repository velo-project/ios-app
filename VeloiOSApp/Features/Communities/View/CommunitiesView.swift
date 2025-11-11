//
//  CommunitiesView.swift
//  VeloiOSApp
//
//  Created by Gabriel Araújo Lima on 01/10/25.
//

import SwiftUI

struct CommunitiesView: View {
    private let viewModel = CommunitiesViewModel()
    
    var body: some View {
        ScrollView {
            VStack(alignment: .leading) {
                VStack {
                    Text("suas comunidades")
                        .bold()
                        .font(.title2)
                    HStack {
                        // TODO
                    }
                }
                .padding()
                
                Text("atividades recentes")
                    .bold()
                    .font(.title2)
                    .padding()
                VStack(spacing: 20) {
                    ForEach(viewModel.posts) { post in
                        VeloPostComponent(issuedBy: post.postedBy, issue: "publicou um post", text: post.content, profileImage: "")
                            .padding(.horizontal)
                    }
                }
            }
        }
        .veloCommonToolbar()
    }
}
