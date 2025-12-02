//
//  RecoveryPasswordResponse.swift
//  VeloiOSApp
//
//  Created by Gabriel Araújo on 02/12/25.
//

// {
//"statusCode": 200,
//"message": "Waiting for confirmation.",
//"key": "d2d98f09-8dc7-42c2-8fec-778480256d6d",
//"timestamp": "2025-12-02T14:53:18.198218054"
//}

import Foundation

struct RecoveryPasswordResponse: Codable {
    var statusCode: Int
    var message: String
    var key: String?
    var timestamp: String
}
