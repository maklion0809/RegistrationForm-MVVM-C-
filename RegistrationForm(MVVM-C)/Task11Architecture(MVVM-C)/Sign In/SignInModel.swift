//
//  SignInModel.swift
//  Task11Architecture(MVVM-C)
//
//  Created by Tymofii (Work) on 26.10.2021.
//

import Foundation

struct SignInModel {
    var login: String?
    var password: String?

    func validateModel() -> User? {
        guard let login = self.login, let password = self.password, !login.isEmpty, !password.isEmpty else { return nil }
        return User(login: login, password: password)
    }
}
