//
//  Endpoint.swift
//  VeloiOSApp
//
//  Created by Gabriel Araújo on 08/11/25.
//

import Foundation

protocol Endpoint {
    var path: String { get }
    var method: String { get }
    var queryItems: [URLQueryItem]? { get }
    var headers: [String: String]? { get }
}

extension Endpoint {
    var baseUrl: URL { URL(string: "")! }
    
    var request: URLRequest {
        var components = URLComponents(url: baseUrl.appendingPathComponent(path), resolvingAgainstBaseURL: false)!
        components.queryItems = queryItems
        var request = URLRequest(url: components.url!)
        request.httpMethod = method
        headers?.forEach { request.setValue($1, forHTTPHeaderField: $0) }
        return request
    }
}
