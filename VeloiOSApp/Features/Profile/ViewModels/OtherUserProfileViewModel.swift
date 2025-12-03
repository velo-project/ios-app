//
//  OtherUserProfileViewModel.swift
//  VeloiOSApp
//
//  Created by Gabriel Araújo on 03/12/25.
//

import Foundation

@MainActor
class OtherUserProfileViewModel: ObservableObject {
    @Published var posts: [PostResponseModel] = []
    @Published var isLoading = false
    @Published var errorMessage: String?
    
    private let socialMediaAPIClient = SocialMediaAPIClient()
    
    func fetchPosts(for user: User) async {
        isLoading = true
        errorMessage = nil
        
        do {
            let feed = try await socialMediaAPIClient.getPostsByNickname(nickname: user.nickname, page: 0)
            self.posts = feed.map { feedItem in
                PostResponseModel(
                    id: feedItem.id,
                    content: feedItem.content,
                    hashtags: feedItem.hashtags.map { "#\($0.tag)" }.joined(separator: " "),
                    postedBy: "",
                    postedById: feedItem.postedBy,
                    postedAt: feedItem.postedAt,
                    postedIn: feedItem.postedIn?.name ?? "Feed Pessoal",
                    profileImage: nil,
                    imageUrl: feedItem.imageUrl,
                    likesCount: 0,
                    isLikedByMe: false
                )
            }
        } catch {
            errorMessage = "Failed to fetch user posts."
        }
        
        isLoading = false
    }
    
    func follow(user: User) async {
        do {
            try await socialMediaAPIClient.followUser(nickname: user.nickname)
        } catch {
            errorMessage = "Failed to follow user."
        }
    }
    
    func unfollow(user: User) async {
        do {
            try await socialMediaAPIClient.unfollowUser(nickname: user.nickname)
        } catch {
            errorMessage = "Failed to unfollow user."
        }
    }
}
