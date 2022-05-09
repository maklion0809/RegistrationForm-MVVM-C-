//
//  User.swift
//  Task11Architecture(MVVM-C)
//
//  Created by Tymofii (Work) on 25.10.2021.
//

import Foundation

struct User {
    private let userLoginKey = "UserLogInKey"
    private let userPasswordKey = "UserPasswordKey"

    let login: String
    let password: String

    var json: [String: String] {
        return [userLoginKey: login,
                userPasswordKey: password]
    }
}

extension User {
    init?(_ userJson: [String: String]) {
        guard let login = userJson[userLoginKey], let password = userJson[userPasswordKey] else { return nil }
        self.login = login
        self.password = password
    }
}
