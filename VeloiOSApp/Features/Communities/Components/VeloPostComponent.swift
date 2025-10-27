//
//  PostComponent.swift
//  VeloiOSApp
//
//  Created by Gabriel Araújo Lima on 01/10/25.
//

import SwiftUI

@ViewBuilder
func VeloPostComponent(issuedBy: String, issue: String, text: String, profileImage: String) -> some View {
    VStack(alignment: .leading) {
        AsyncImage(url: URL(string: profileImage)) { phase in
            if let image = phase.image {
                image
                    .resizable()
                    .aspectRatio(contentMode: .fit)
                    .frame(width: 30)
                    .clipShape(.circle)
            } else {
                Circle()
                    .fill(.black)
                    .frame(width: 30, height: 30)
            }
        }
            
        Text(issuedBy + " " + issue)
        Text(text)
            .font(.headline)
            .bold()
    }
    .padding(30)
    .frame(maxWidth: .infinity, alignment: .leading)
    .background(.white)
    .clipShape(RoundedRectangle(cornerRadius: 20))
    .shadow(color: .black.opacity(0.1), radius: 4, x: 0, y: 3)
}
