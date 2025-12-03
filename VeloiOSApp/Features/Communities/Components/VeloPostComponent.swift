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
    
    @State private var user: FetchUserResponse?
    
    var body: some View {
        VStack(alignment: .leading, spacing: 12) {
            HStack(spacing: 10) {
                if let user = user {
                    NavigationLink(value: ViewDestination.otherUserProfile(user: user.user)) {
                        HStack(spacing: 10) {
                            if let urlString = user.user.profilePhotoUrl ?? post.profileImage, let url = URL(string: urlString) {
                                AsyncImage(url: url) { phase in
                                    if let image = phase.image {
                                        image
                                            .resizable()
                                            .aspectRatio(contentMode: .fill)
                                            .frame(width: 44, height: 44)
                                            .clipShape(Circle())
                                    } else if phase.error != nil {
                                        // Error view
                                        Image(systemName: "person.circle.fill")
                                            .resizable()
                                            .frame(width: 44, height: 44)
                                            .foregroundColor(.gray)
                                    } else {
                                        // Placeholder
                                        Circle()
                                            .fill(Color.gray.opacity(0.1))
                                            .frame(width: 44, height: 44)
                                    }
                                }
                            } else {
                                // Fallback view if URL is nil
                                Image(systemName: "person.circle.fill")
                                    .resizable()
                                    .frame(width: 44, height: 44)
                                    .foregroundColor(.gray)
                            }
                            
                            VStack(alignment: .leading, spacing: 2) {
                                Text(user.user.name)
                                    .bold()
                                Text("publicou em \(post.postedIn)")
                                    .foregroundColor(.gray)
                            }
                        }
                    }
                    .buttonStyle(.plain)
                } else {
                    // Fallback for when user is not loaded yet
                    HStack(spacing: 10) {
                        Image(systemName: "person.circle.fill")
                            .resizable()
                            .frame(width: 44, height: 44)
                            .foregroundColor(.gray)
                        
                        VStack(alignment: .leading, spacing: 2) {
                            Text(post.postedBy)
                                .bold()
                            Text("publicou em \(post.postedIn)")
                                .foregroundColor(.gray)
                        }
                    }
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
        .frame(maxWidth: .infinity, alignment: .leading)
        .padding(20)
        .background(Color(uiColor: .systemBackground))
        .clipShape(RoundedRectangle(cornerRadius: 16))
        .shadow(color: .black.opacity(0.08), radius: 8, x: 0, y: 4)
        .task {
            await fetchUser()
        }
    }
    
    private func fetchUser() async {
        let client = UserAPIClient()
        do {
            let userResponse = try await client.searchUserById(id: post.postedById)
            self.user = userResponse
        } catch {
            print("Error fetching user: \(error)")
        }
    }
}

