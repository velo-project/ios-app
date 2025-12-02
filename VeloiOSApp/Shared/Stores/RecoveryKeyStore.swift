//
//  RecoveryKeyStore.swift
//  VeloiOSApp
//
//  Created by Gabriel Araújo Lima on 02/12/25.
//

import Foundation

final class RecoveryKeyStore {
    static let shared = RecoveryKeyStore()
    private let userDefaults: UserDefaults
    
    private init(userDefaults: UserDefaults = .standard) {
        self.userDefaults = userDefaults
    }
    
    func saveKey(key: String) {
        userDefaults.set(key, forKey: "recovery_key")
    }
    
    func getKey() -> String? {
        userDefaults.string(forKey: "recovery_key")
    }
    
    func deleteKey() {
        userDefaults.removeObject(forKey: "recovery_key")
    }
}
