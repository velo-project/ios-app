//
//  DataExtensions.swift
//  VeloiOSApp
//
//  Created by Gabriel Araújo on 09/11/25.
//

import Foundation

extension Data {
    mutating func append(_ string: String) {
        if let data = string.data(using: .utf8) {
            append(data)
        }
    }
}

func decodeJWTPart(_ value: String) -> [String: Any]? {
    guard let bodyData = base64UrlDecode(value) else {
        return nil
    }
    return try? JSONSerialization.jsonObject(with: bodyData, options: []) as? [String: Any]
}

func base64UrlDecode(_ value: String) -> Data? {
    var base64 = value
        .replacingOccurrences(of: "-", with: "+")
        .replacingOccurrences(of: "_", with: "/")
    let length = Double(base64.lengthOfBytes(using: .utf8))
    let requiredLength = 4 * ceil(length / 4.0)
    let padding = requiredLength - length
    if padding > 0 {
        let paddingString = String(repeating: "=", count: Int(padding))
        base64 += paddingString
    }
    return Data(base64Encoded: base64)
}
