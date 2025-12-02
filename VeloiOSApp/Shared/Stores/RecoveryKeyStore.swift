//
//  RecoveryKeyStore.swift
//  VeloiOSApp
//
//  Created by Gabriel Araújo Lima on 02/12/25.
//

import Foundation
import KeychainSwift

final class RecoveryKeyStore {
    static let shared = RecoveryKeyStore()
    private let keychain: KeychainSwift
    
    private init(keychain: KeychainSwift = KeychainSwift()) {
        self.keychain = keychain
    }
    
    func saveKey(key: String) {
        keychain.set(key, forKey: "recovery_key")
    }
    
    func getKey() -> String? {
        keychain.get("recovery_key")
    }
    
    func deleteKey() {
        keychain.delete("recovery_key")
    }
}
