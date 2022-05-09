//
//  SignUpModel.swift
//  Task11Architecture(MVVM-C)
//
//  Created by Tymofii (Work) on 26.10.2021.
//

import Foundation

struct SignUpModel {
    var username: String?
    var password: String?
    var confirmPassword: String?

    func validateModel() -> User? {
        guard let login = self.username, let password = self.password, !login.isEmpty, !password.isEmpty, self.password == self.confirmPassword else { return nil }
        return User(login: login, password: password)
    }
}
