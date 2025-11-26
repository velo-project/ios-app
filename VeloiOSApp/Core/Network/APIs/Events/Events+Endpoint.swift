import Foundation

enum EventsEndpoint {
    case getEvents
    case subscribe(id: String)
    case getConfirmationCode(id: String)
}

extension EventsEndpoint: Endpoint {
    var queryItems: [URLQueryItem]? {
        switch self {
        default:
            return nil
        }
    }
    
    var path: String {
        switch self {
        case .getEvents:
            return "/api/events/v1/events"
        case .subscribe(let id):
            return "/api/events/v1/subscribe/\(id)"
        case .getConfirmationCode(let id):
            return "/api/events/v1/confirmation-code/\(id)"
        }
    }

    var method: String {
        switch self {
        case .getEvents, .getConfirmationCode:
            return "GET"
        case .subscribe:
            return "POST"
        }
    }

    var headers: [String: String]? {
        let token = TokenStore().getJwtToken().token ?? ""
        return [
            "Accept": "application/json",
            "Authorization": "Bearer \(token)"
        ]
    }

    var body: Data? {
        return nil
    }
}
