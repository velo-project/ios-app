//
//  User+Endpoint.swift
//  VeloiOSApp
//
//  Created by Gabriel Araújo on 09/11/25.
//

import Foundation

enum UserEndpoint: Endpoint {
    // MARK: - User
    case search(nickname: String)
    
    // MARK: - Auth
    case login(email: String, password: String)
    case verificationCode(key: String, code: String)
    case register(name: String, nickname: String, email: String, password: String)
    case refreshToken(token: String)
    
    // MARK: - Edit User Profile
    case editBanner(imageData: Data)
    case editProfile(field: String, fieldValue: String)
    case editPhoto(imageData: Data)
    
    // MARK: - Admin
    case blockUser(nickname: String)
    case unblockUser(nickname: String)
    case deleteUser(nickname: String)
    
    // MARK: - Base Paths
    var path: String {
        switch self {
        case .search: return "/api/user/v1/search"
        case .login: return "/api/user/v1/login"
        case .verificationCode: return "/api/user/v1/login/2fa"
        case .refreshToken: return "/api/user/v1/refresh"
        case .register: return "/api/user/v1/register"
        case .editBanner: return "/api/user/v1/edit_banner"
        case .editProfile: return "/api/user/v1/edit_profile"
        case .editPhoto: return "/api/user/v1/edit_photo"
        case .blockUser: return "/api/user/v1/block"
        case .unblockUser: return "/api/user/v1/unblock"
        case .deleteUser: return "/api/user/v1/delete"
        }
    }
    
    // MARK: - HTTP Method
    var method: String {
        switch self {
        case .search:
            return "GET"
        case .login, .verificationCode, .register, .refreshToken:
            return "POST"
        case .editBanner, .editProfile, .editPhoto, .blockUser, .unblockUser:
            return "PATCH"
        case .deleteUser:
            return "DELETE"
        }
    }
    
    // MARK: - Headers
    var headers: [String: String]? {
        let token = TokenStore().getJwtToken().token ?? ""
        var baseHeaders: [String: String] = [
            "Accept": "application/json",
            "Content-Type": "application/json"
        ]
        
        switch self {
        case .search, .login, .verificationCode, .register, .refreshToken:
            return baseHeaders
        default:
            baseHeaders["Authorization"] = "Bearer \(token)"
            return baseHeaders
        }
    }
    
    // MARK: - Query Items
    var queryItems: [URLQueryItem]? {
        switch self {
        case .search(let nickname):
            return [URLQueryItem(name: "nickname", value: nickname)]
        case .blockUser(let nickname),
                .unblockUser(let nickname),
                .deleteUser(let nickname):
            return [URLQueryItem(name: "nickname", value: nickname)]
        default:
            return nil
        }
    }
    
    // MARK: - Body
    var body: Data? {
        switch self {
        case .login(let email, let password):
            return try? JSONSerialization.data(withJSONObject: [
                "email": email,
                "password": password
            ])
        case .refreshToken(let token):
            return try? JSONSerialization.data(withJSONObject: [
                "refreshToken": token
            ])
        case .verificationCode(let key, let code):
            return try? JSONSerialization.data(withJSONObject: [
                "key": key,
                "code": code
            ])
        case .register(let name, let nickname, let email, let password):
            return try? JSONSerialization.data(withJSONObject: [
                "name": name,
                "nickname": nickname,
                "email": email,
                "password": password
            ])
        case .editProfile(let field, let fieldValue):
            return try? JSONSerialization.data(withJSONObject: [
                "field": field,
                "fieldValue": fieldValue
            ])
        case .editBanner(let imageData), .editPhoto(let imageData):
            let boundary = UUID().uuidString
            var body = Data()
            let lineBreak = "\r\n"
            
            body.append("--\(boundary + lineBreak)")
            body.append("Content-Disposition: form-data; name=\"image\"; filename=\"image.jpg\"\(lineBreak)")
            body.append("Content-Type: image/jpeg\(lineBreak + lineBreak)")
            body.append(imageData)
            body.append(lineBreak)
            body.append("--\(boundary)--\(lineBreak)")
            
            return body
        default:
            return nil
        }
    }
}
