//
//  PostComponent.swift
//  VeloiOSApp
//
//  Created by Gabriel Araújo Lima on 01/10/25.
//

import SwiftUI

struct VeloPostComponent: View {
    let post: PostResponseModel
    var onLikeTapped: () -> Void
    
    var body: some View {
        VStack(alignment: .leading, spacing: 12) {
            // ... (código do cabeçalho do post continua o mesmo)
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
                    Text("publicou em \(post.postedIn) • \(post.postedAt)")
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
            
            // --- Nova Seção de Ações ---
            HStack(spacing: 16) {
                Button(action: onLikeTapped) {
                    HStack(spacing: 4) {
                        Image(systemName: post.isLikedByMe ? "heart.fill" : "heart")
                            .foregroundColor(post.isLikedByMe ? .red : .gray)
                        Text("\(post.likesCount)")
                            .font(.custom("Outfit-Medium", size: 14))
                            .foregroundColor(.gray)
                    }
                }
                
                Button(action: {
                    // TODO: Implementar ação de comentar
                }) {
                    HStack(spacing: 4) {
                        Image(systemName: "bubble.left")
                            .foregroundColor(.gray)
                        // TODO: Adicionar contador de comentários quando a API suportar
                        // Text("0")
                    }
                }
                
                Spacer()
            }
            .padding(.top, 8)
            
        }
        .padding(20)
        .background(Color(uiColor: .systemBackground))
        .clipShape(RoundedRectangle(cornerRadius: 16))
        .shadow(color: .black.opacity(0.08), radius: 8, x: 0, y: 4)
    }
}

