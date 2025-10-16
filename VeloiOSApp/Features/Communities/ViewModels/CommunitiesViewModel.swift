//
//  CommunitiesViewModel.swift
//  VeloiOSApp
//
//  Created by Gabriel Araújo Lima on 01/10/25.
//

import Foundation

class CommunitiesViewModel: ObservableObject {
    @Published var posts: [PostResponseModel] = []
    
    init() {
        self.posts = [
            PostResponseModel(
                content: "Estou adorando aprender SwiftUI! É muito mais declarativo que o UIKit.",
                hashtags: "#swiftui #iosdev #apple",
                postedBy: "Ana Silva",
                postedAt: Date().addingTimeInterval(-3600), // 1 hora atrás
                postedIn: "Comunidade iOS Brasil"
            ),
            PostResponseModel(
                content: "Qual a melhor forma de gerenciar estado em um app complexo? 🤔",
                hashtags: "#swift #statemanagement #arquitetura",
                postedBy: "Carlos Mendes",
                postedAt: Date().addingTimeInterval(-18000), // 5 horas atrás
                postedIn: "Arquitetura de Software"
            ),
            PostResponseModel(
                content: "Acabei de publicar meu primeiro aplicativo na App Store! 🚀 Foi um grande desafio, mas valeu a pena.",
                hashtags: "#appstore #indiedev #sucesso",
                postedBy: "Maria Souza",
                postedAt: Date().addingTimeInterval(-86400), // 1 dia atrás
                postedIn: "Comunidade iOS Brasil"
            ),
            PostResponseModel(
                content: "Dica do dia: usem o novo componente Observation para simplificar suas views no iOS 17.",
                hashtags: "#ios17 #observation #dica",
                postedBy: "Pedro Lima",
                postedAt: Date().addingTimeInterval(-172800), // 2 dias atrás
                postedIn: "Novidades do Swift"
            )
        ]
    }
}
