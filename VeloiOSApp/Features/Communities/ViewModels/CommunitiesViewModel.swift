//
//  CommunitiesViewModel.swift
//  VeloiOSApp
//
//  Created by Gabriel Araújo Lima on 01/10/25.
//

import Foundation
import Combine

@MainActor
class CommunitiesViewModel: ObservableObject {
    @Published var posts: [PostResponseModel] = []
    @Published var isLoading: Bool = false
    @Published var errorMessage: String?

    private let socialMediaAPIClient: SocialMediaAPIClient

    init(socialMediaAPIClient: SocialMediaAPIClient = SocialMediaAPIClient()) {
        self.socialMediaAPIClient = socialMediaAPIClient
    }

    func fetchPosts() async {
        isLoading = true
        errorMessage = nil
        
        do {
            let feed = try await socialMediaAPIClient.getFeed()
            
            // FIXME: The API only returns a user ID (`postedBy`).
            // We need an endpoint like `getUser(byId: Int)` to fetch user details.
            // For now, we are using placeholder data.
            self.posts = feed.map { post in
                PostResponseModel(
                    content: post.content,
                    hashtags: post.hashtags.map { "#\($0)" }.joined(separator: " "),
                    postedBy: "Usuário \(post.postedBy)", // Placeholder
                    postedAt: post.postedAt,
                    postedIn: post.postedIn.name,
                    profileImage: "https://i.pravatar.cc/50?u=\(post.postedBy)" // Placeholder
                )
            }
        } catch {
            errorMessage = "Erro ao carregar o feed. Tente novamente mais tarde."
            // TODO: Log the actual error for debugging
            print(error.localizedDescription)
        }
        
        isLoading = false
    }
}
