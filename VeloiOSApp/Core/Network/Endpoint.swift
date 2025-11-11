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
    var body: Data? { get }
}

extension Endpoint {
    #warning("Trocar a URL antes do build")
    var baseUrl: URL { URL(string: "http://192.168.0.16")! }
    
    var request: URLRequest {
        var components = URLComponents(url: baseUrl.appendingPathComponent(path), resolvingAgainstBaseURL: false)!
        components.queryItems = queryItems
        var request = URLRequest(url: components.url!)
        request.httpMethod = method
        request.httpBody = body
        headers?.forEach { request.setValue($1, forHTTPHeaderField: $0) }
        return request
    }
}
