//
//  SignInViewModel.swift
//  Task11Architecture(MVVM-C)
//
//  Created by Tymofii (Work) on 26.10.2021.
//

import Foundation

protocol SignInViewModelInterface {
    func loginDidChange(_ text: String?)
    func passwordDidChange(_ text: String?)

    func handleSignInAction()
    func handleSignUpAction()
    
    var signInViewDelegate: SignInViewInterfaceDelegate? { get set }
}

final class SignInViewModel: SignInViewModelInterface {
    
    // MARK: - Variable
    
    var coordinatorDelegate: SignInCoordinatorDelegate?
    weak var signInViewDelegate: SignInViewInterfaceDelegate?
    private var model: SignInModel
    private let storage: UserSession = .shared
    
    // MARK: - Initialization

    init(model: SignInModel = .init()) {
        self.model = model
    }
    
    // MARK: - SignInViewModelInterface

    func loginDidChange(_ text: String?) {
        model.login = text
    }

    func passwordDidChange(_ text: String?) {
        model.password = text
    }

    func handleSignInAction() {
        signInViewDelegate?.resignAllResponders()
        guard let user = model.validateModel() else {
            signInViewDelegate?.handlingError(message: "Not all fields are filled!")
            return
        }
        guard let storedUser = storage.getUser(with: user.login), storedUser.password == user.password else {
            signInViewDelegate?.handlingError(message: "Incorrect login or password!")
            return
        }
        storage.saveCurrentUser(user)
        coordinatorDelegate?.signInDidComplete()
    }

    func handleSignUpAction() {
        signInViewDelegate?.resignAllResponders()
        coordinatorDelegate?.userInitiatedSignUp()
    }
}
