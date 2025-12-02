//
//  CommunitiesViewModel.swift
//  VeloiOSApp
//
//  Created by Gabriel Araújo Lima on 01/10/25.
//

import Foundation
import Combine
import Sentry

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
            let feeds = try await socialMediaAPIClient.getFeed()
            
            // TODO: The API only returns a user ID (`postedBy`).
            // We need an endpoint like `getUser(byId: Int)` to fetch user details.
            // For now, we are using placeholder data.
            self.posts = feeds.feed.map { post in
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
            if let apiError = error as? APIError {
                switch apiError {
                case .unauthorized:
                    errorMessage = "Sessão expirada. Por favor, faça login novamente."
                case .badServerResponse:
                    errorMessage = "O servidor não está respondendo. Tente novamente mais tarde."
                    SentrySDK.capture(error: error)
                }
            } else {
                errorMessage = "Erro ao carregar o feed. Verifique sua conexão e tente novamente."
                SentrySDK.capture(error: error)
            }
            print("Failed to fetch posts: \(error)")
        }
        
        isLoading = false
    }
}
