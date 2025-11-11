//
//  MFAKeyStore.swift
//  VeloiOSApp
//
//  Created by Gabriel Araújo on 11/11/25.
//

import KeychainSwift

class MFAKeyStore {
    private let keychan = KeychainSwift()
    private let identifier = "com.velo.mfa.key"
    
    func saveKey(key: String) {
        deleteToken()
        keychan.set(key, forKey: identifier)
    }
    
    func getKey() -> String? {
        return keychan.get(identifier)
    }
    
    func deleteToken() {
        keychan.delete(identifier)
    }
}
