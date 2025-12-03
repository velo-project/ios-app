//
//  CommunitiesViewModel.swift
//  VeloiOSApp
//
//  Created by Gabriel Araújo Lima on 01/10/25.
//

import Foundation
import Combine
import Sentry
import UIKit

@MainActor
class CommunitiesViewModel: ObservableObject {
    // MARK: - Estados da Tela
    @Published var posts: [PostResponseModel] = []
    @Published var communities: [Community] = []
    @Published var friends: [String] = []
    
    // MARK: - Estados da Criação de Post
    @Published var newPostContent: String = ""
    @Published var isCreatingPost: Bool = false
    @Published var createPostError: String?
    
    @Published var isLoading: Bool = false
    @Published var errorMessage: String?
    
    // Controle das abas: 0 = Feed, 1 = Comunidades, 2 = Amigos
    @Published var selectedPage = 0 {
        didSet {
            Task { await loadDataForCurrentPage() }
        }
    }

    private let socialMediaAPIClient: SocialMediaAPIClient
    private let nicknameStore: NicknameStore

    init(
        socialMediaAPIClient: SocialMediaAPIClient = SocialMediaAPIClient(),
        nicknameStore: NicknameStore = NicknameStore()
    ) {
        self.socialMediaAPIClient = socialMediaAPIClient
        self.nicknameStore = nicknameStore
    }

    // MARK: - Carregamento de Dados
    
    func loadDataForCurrentPage() async {
        guard !isLoading else { return } // Evita chamadas duplicadas
        isLoading = true
        errorMessage = nil
        
        do {
            switch selectedPage {
            case 0:
                await fetchFeed()
            case 1:
                await fetchUserCommunities()
            case 2:
                await fetchFriends()
            default:
                break
            }
        } catch {
            handleError(error)
        }
        
        isLoading = false
    }

    func fetchFeed() async {
        do {
            let response = try await socialMediaAPIClient.getFeed()
            
            self.posts = response.feed.map { feedItem in
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
            print("Fetched posts: \(self.posts)")
        } catch {
            handleError(error)
        }
    }
    
    private func fetchUserCommunities() async {
        guard let nickname = nicknameStore.getNickname() else {
            errorMessage = "Nickname não encontrado para buscar comunidades."
            return
        }
        
        do {
            let communityIds = try await socialMediaAPIClient.getUserCommunities(nickname: nickname)
            
            // Usando um TaskGroup para buscar detalhes das comunidades em paralelo
            self.communities = await withTaskGroup(of: GetCommunityByIdResponse?.self, returning: [Community].self) { group in
                for id in communityIds {
                    group.addTask {
                        try? await self.socialMediaAPIClient.getCommunityById(communityId: id)
                    }
                }
                
                var collected: [Community] = []
                for await response in group {
                    if let community = response?.community {
                        collected.append(community)
                    }
                }
                return collected
            }
        } catch {
            handleError(error)
        }
    }
    
    private func fetchFriends() async {
        do {
            let friendsList = try await socialMediaAPIClient.getFriends()
            self.friends = friendsList
        } catch {
            handleError(error)
        }
    }

    // MARK: - Ações do Usuário (Like)
    
    func toggleLike(postID: Int) async {
        guard let index = posts.firstIndex(where: { $0.id == postID }) else { return }
         
        let originalPost = posts[index]
        let isNowLiked = !originalPost.isLikedByMe
        
        posts[index].isLikedByMe = isNowLiked
        posts[index].likesCount += isNowLiked ? 1 : -1
        
        do {
            if isNowLiked {
                try await socialMediaAPIClient.likePost(postId: postID)
            } else {
                try await socialMediaAPIClient.unlikePost(postId: postID)
            }
        } catch {
            // Se falhar, reverte a UI
            posts[index] = originalPost
            print("Erro ao dar like: \(error)")
        }
    }

    // MARK: - Ações de Post
    
    func createPost() async {
        guard !newPostContent.isEmpty else { return }
        
        isCreatingPost = true
        createPostError = nil
        
        do {
            // A API espera um ID opcional de comunidade e dados de imagem.
            // Por enquanto, vamos passar nil para ambos.
            _ = try await socialMediaAPIClient.publishPost(
                content: newPostContent,
                postedIn: nil, // TODO: Permitir que o usuário selecione uma comunidade
                imageData: nil   // TODO: Permitir que o usuário adicione uma imagem
            )
            
            // Limpar e recarregar
            newPostContent = ""
            await fetchFeed()
            
        } catch {
            // Define o erro específico para a UI de criação de post
            createPostError = "Falha ao publicar o post. Tente novamente."
            // Imprime o erro real no console para depuração
            print("Falha ao criar post: \(error)")
            // Envia o erro inesperado para o Sentry
            SentrySDK.capture(error: error)
        }
        
        isCreatingPost = false
    }

    // MARK: - Helpers
    
    private func handleError(_ error: Error) {
        print("Erro capturado: \(error)")
        if let apiError = error as? APIError {
            switch apiError {
            case .unauthorized:
                errorMessage = "Sessão expirada."
            case .badServerResponse:
                errorMessage = "Erro no servidor."
                SentrySDK.capture(error: error)
            }
        } else {
            errorMessage = "Erro de conexão ou decodificação."
            SentrySDK.capture(error: error)
        }
    }
}

