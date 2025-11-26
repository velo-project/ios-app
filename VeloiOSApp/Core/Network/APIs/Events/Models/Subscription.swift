import Foundation

struct SubscribeResponse: Codable {
    let message: String
    let confirmationCode: String
    let statusCode: Int

    enum CodingKeys: String, CodingKey {
        case message
        case confirmationCode = "confirmation_code"
        case statusCode = "status_code"
    }
}

struct ConfirmationCodeResponse: Codable {
    let message: String
    let confirmationCode: String
    let statusCode: Int

    enum CodingKeys: String, CodingKey {
        case message
        case confirmationCode = "confirmation_code"
        case statusCode = "status_code"
    }
}
