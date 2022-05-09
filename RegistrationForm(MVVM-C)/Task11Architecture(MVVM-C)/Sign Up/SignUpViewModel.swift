//
//  SignUpViewModel.swift
//  Task11Architecture(MVVM-C)
//
//  Created by Tymofii (Work) on 26.10.2021.
//

import Foundation

protocol SignUpViewModelInterface {
    func usernameDidChange(with text: String?)
    func passwordDidChange(with text: String?)
    func confirmPasswordDidChange(with text: String?)
    
    func handleSignUpButtonAction()
    
    var signUpViewDelegate: SignUpViewInterfaceDelegate? { get set }
}

final class SignUpViewModel: SignUpViewModelInterface {
    
    // MARK: - Variable
    
    weak var coordinatorDelegate: SignUpCoordinatorDelegate?
    weak var signUpViewDelegate: SignUpViewInterfaceDelegate?
    private var model: SignUpModel
    private let storage: UserSession = .shared

    // MARK: - Initialization
    
    init(model: SignUpModel = .init()) {
        self.model = model
    }
    
    // MARK: - SignUpViewModelInterface

    func usernameDidChange(with text: String?) {
        model.username = text
    }

    func passwordDidChange(with text: String?) {
        model.password = text
    }

    func confirmPasswordDidChange(with text: String?) {
        model.confirmPassword = text
    }

    func handleSignUpButtonAction() {
        signUpViewDelegate?.resignAllResponders()
        guard let user = model.validateModel() else {
            signUpViewDelegate?.handlingError(message: "Data entered incorrectly!")
            return
        }
        storage.saveNewUser(user)
        storage.saveCurrentUser(user)
        coordinatorDelegate?.signUpDidComplete()
    }
}
