//
//  NicknameStore.swift
//  VeloiOSApp
//
//  Created by Gabriel Araújo Lima on 09/12/25.
//

import Foundation
import KeychainSwift

class NicknameStore: ObservableObject {
    static let shared = NicknameStore()
    private var keychan = KeychainSwift()

    private let nicknameKey = "com.velo.user.nickname"

    func saveNickname(nickname: String) {
        keychan.set(nickname, forKey: nicknameKey)
    }

    func getNickname() -> String? {
        return keychan.get(nicknameKey)
    }

    func deleteNickname() {
        keychan.delete(nicknameKey)
    }
}
