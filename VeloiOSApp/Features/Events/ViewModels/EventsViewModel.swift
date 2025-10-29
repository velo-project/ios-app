//
//  EventsViewModel.swift
//  VeloiOSApp
//
//  Created by Gabriel Araújo Lima on 22/10/25.
//

import Foundation

class EventsViewModel: ObservableObject {
    @Published var forYouEvents: [BrandEventsModel]
    @Published var trendingEvents: [BrandEventsModel]
    @Published var lastKnowEvents: [BrandEventsModel]
    @Published var subscribedEvents: [BrandEventsModel] = []
    
    @Published var selectedEvent: BrandEventsModel? = nil
    
    init() {
        self.forYouEvents = [
            BrandEventsModel(
                imageUrl: "https://picsum.photos/seed/foryou1/480/280",
                title: "Pedal no Pico do Jaraguá",
                description: "Uma subida desafiadora até o ponto mais alto de São Paulo. Junte-se a nós para vistas incríveis e muita superação."
            ),
            BrandEventsModel(
                imageUrl: "https://picsum.photos/seed/foryou2/480/280",
                title: "Giro Ciclístico da Cantareira",
                description: "Explore a beleza da Serra da Cantareira em um percurso de 50km com trechos de asfalto e terra. Ideal para todos os níveis."
            ),
            BrandEventsModel(
                imageUrl: "https://picsum.photos/seed/foryou3/480/280",
                title: "Oficina de Manutenção Básica",
                description: "Aprenda a fazer pequenos reparos na sua bike e nunca mais fique na mão. Vagas limitadas!"
            ),
            BrandEventsModel(
                imageUrl: "https://picsum.photos/seed/foryou4/480/280",
                title: "Tour Histórico pelo Centro de SP",
                description: "Um passeio cultural de bicicleta pelos principais marcos históricos do centro de São Paulo. Ritmo leve e muitas paradas para fotos."
            )
        ]
        
        self.trendingEvents = [
            BrandEventsModel(
                imageUrl: "https://picsum.photos/seed/trending1/480/280",
                title: "Desafio 100km Estrada dos Romeiros",
                description: "Um evento para ciclistas experientes que buscam testar seus limites em uma das estradas mais cênicas do estado."
            ),
            BrandEventsModel(
                imageUrl: "https://picsum.photos/seed/trending2/480/280",
                title: "MTB na Trilha do Silêncio",
                description: "Aventura e adrenalina em uma trilha técnica em Mairiporã. Prepare-se para muita lama e diversão."
            ),
            BrandEventsModel(
                imageUrl: "https://picsum.photos/seed/trending3/480/280",
                title: "Bike Anjo: Aprenda a Pedalar",
                description: "Evento gratuito para todas as idades. Nossos voluntários estão prontos para ajudar você a dar suas primeiras pedaladas com segurança."
            ),
            BrandEventsModel(
                imageUrl: "https://picsum.photos/seed/trending4/480/280",
                title: "Passeio Noturno na Ciclovia Rio Pinheiros",
                description: "Curta a cidade iluminada em um pedal seguro e tranquilo pela ciclovia. Não se esqueça das luzes de segurança!"
            )
        ]
        
        // --- Últimos Eventos Vistos/Próximos ---
        self.lastKnowEvents = [
            BrandEventsModel(
                imageUrl: "https://picsum.photos/seed/lastknow1/480/280",
                title: "Café & Bike na Vila Madalena",
                description: "Um encontro casual para amantes do ciclismo e de um bom café. Venha compartilhar histórias e fazer novas amizades."
            ),
            BrandEventsModel(
                imageUrl: "https://picsum.photos/seed/lastknow2/480/280",
                title: "Granfondo Araxá 2025",
                description: "Prepare-se para uma das provas de ciclismo de estrada mais famosas do Brasil. Inscrições abertas."
            ),
            BrandEventsModel(
                imageUrl: "https://picsum.photos/seed/lastknow3/480/280",
                title: "Pedal Solidário de Inverno",
                description: "Traga sua bike e um agasalho para doação. Vamos pedalar por uma boa causa e aquecer quem mais precisa."
            )
        ]
    }
    
    func subscribe(event: BrandEventsModel) {
        if subscribedEvents.contains(where: { $0.id == event.id }) {
            // Se o evento já existe na lista, remove.
            subscribedEvents.removeAll { $0.id == event.id }
        } else {
            // Se não existe, adiciona no início da lista.
            subscribedEvents.insert(event, at: 0)
        }
    }
    
    func isSubscribed(to event: BrandEventsModel) -> Bool {
        return subscribedEvents.contains { $0.id == event.id }
    }
}

