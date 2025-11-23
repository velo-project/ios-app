//
//  PostComponent.swift
//  VeloiOSApp
//
//  Created by Gabriel Araújo Lima on 01/10/25.
//

import SwiftUI

struct VeloPostComponent: View {
    let post: PostResponseModel
    
    var body: some View {
        VStack(alignment: .leading, spacing: 12) {
            HStack(spacing: 10) {
                AsyncImage(url: URL(string: post.profileImage ?? "")) { phase in
                    if let image = phase.image {
                        image
                            .resizable()
                            .aspectRatio(contentMode: .fill)
                            .frame(width: 44, height: 44)
                            .clipShape(Circle())
                    } else if phase.error != nil {
                        Image(systemName: "person.circle.fill")
                            .resizable()
                            .frame(width: 44, height: 44)
                            .foregroundColor(.gray)
                    } else {
                        Circle()
                            .fill(Color.gray.opacity(0.1))
                            .frame(width: 44, height: 44)
                    }
                }
                
                VStack(alignment: .leading, spacing: 2) {
                    Text(post.postedBy)
                        .font(.custom("Outfit-Bold", size: 16))
                    Text("publicou em \(post.postedIn) • \(post.postedAt.timeAgoDisplay())")
                        .font(.custom("Outfit-Regular", size: 14))
                        .foregroundColor(.gray)
                }
            }
            
            Text(post.content)
                .font(.custom("Outfit-Regular", size: 16))
                .lineSpacing(4)
            
            if !post.hashtags.isEmpty {
                Text(post.hashtags)
                    .font(.custom("Outfit-Medium", size: 14))
                    .foregroundColor(.accentColor)
            }
        }
        .padding(20)
        .background(Color(uiColor: .systemBackground))
        .clipShape(RoundedRectangle(cornerRadius: 16))
        .shadow(color: .black.opacity(0.08), radius: 8, x: 0, y: 4)
    }
}

// Preview Provider for easy debugging in Xcode Previews
struct VeloPostComponent_Previews: PreviewProvider {
    static var previews: some View {
        let samplePost = PostResponseModel(
            content: "Acabei de testar o novo percurso de montanha! 🚵‍♂️ As vistas são incríveis e o desafio é na medida certa. Quem mais já foi?",
            hashtags: "#ciclismo #trilha #aventura",
            postedBy: "Joana Alves",
            postedAt: Date().addingTimeInterval(-3600), // 1 hour ago
            postedIn: "Amantes de Ciclismo",
            profileImage: "https://i.pravatar.cc/100?u=joana"
        )
        
        VeloPostComponent(post: samplePost)
            .padding()
            .background(Color.gray.opacity(0.1))
    }
}
