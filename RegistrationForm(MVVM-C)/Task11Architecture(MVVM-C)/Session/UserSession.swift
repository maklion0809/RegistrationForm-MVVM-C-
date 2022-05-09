//
//  Session.swift
//  Task11Architecture(MVVM-C)
//
//  Created by Tymofii (Work) on 25.10.2021.
//

import Foundation

final class UserSession {
    private let storedUsersKey = "StoredUsersKey"
    private let currentUserKey = "CurrentUserKey"
    private let storage: UserDefaults = .standard

    static let shared = UserSession()

    func saveNewUser(_ user: User) {
        if var array = storage.array(forKey: storedUsersKey) as? [[String: String]] {
            if let index = array.firstIndex(where: { $0.contains(where: { $0.value == user.login })}) {
                array[index] = user.json
            } else {
                array.append(user.json)
            }
            storage.setValue(array, forKey: storedUsersKey)
        } else {
            storage.setValue([user.json], forKey: storedUsersKey)
        }
    }

    func saveCurrentUser(_ user: User) {
        storage.setValue(user.json, forKey: currentUserKey)
    }

    func getUser(with login: String) -> User? {
        guard let array = storage.array(forKey: storedUsersKey) as? [[String: String]],
              let userJson = array.first(where: { $0.values.contains(login) }) else { return nil }
        return User(userJson)
    }
    
    var wasUserLoggedIn: User? {
        guard let userJson = storage.value(forKey: currentUserKey) as? [String: String] else {
            return nil
        }
        return User(userJson)
    }

    func cleanActiveSession() {
        storage.removeObject(forKey: currentUserKey)
    }
}
