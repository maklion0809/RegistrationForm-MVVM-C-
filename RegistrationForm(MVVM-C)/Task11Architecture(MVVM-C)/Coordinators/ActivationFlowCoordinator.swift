//
//  ActivationFlowCoordinator.swift
//  Task11Architecture(MVVM-C)
//
//  Created by Tymofii (Work) on 26.10.2021.
//

import UIKit

protocol SignInCoordinatorDelegate: AnyObject {
    func signInDidComplete()
    func userInitiatedSignUp()
}

protocol SignUpCoordinatorDelegate: AnyObject {
    func signUpDidComplete()
}

protocol ActivationFlowCoordinatorDelegate: AnyObject {
    func userFinishedActivationFlow()
}

final class ActivationFlowCoordinator: Coordinator, SignInCoordinatorDelegate, SignUpCoordinatorDelegate {
    weak var delegate: ActivationFlowCoordinatorDelegate?
    private let navigationController = UINavigationController()
    private let window: UIWindow

    init(window: UIWindow) {
        self.window = window
    }
    
    func start() {
        window.rootViewController = navigationController
        let controller = SignInViewController()
        let viewModel = SignInViewModel()
        viewModel.coordinatorDelegate = self
        controller.viewModel = viewModel
        navigationController.pushViewController(controller, animated: true)
    }
    
    // MARK: - SignInNavigation
    
    func signInDidComplete() {
        delegate?.userFinishedActivationFlow()
    }
    
    func userInitiatedSignUp() {
        let controller = SignUpViewController()
        let viewModel = SignUpViewModel()
        viewModel.coordinatorDelegate = self
        controller.viewModel = viewModel
        navigationController.pushViewController(controller, animated: true)
    }
    
    // MARK: - SignUpNavigation
    
    func signUpDidComplete() {
        delegate?.userFinishedActivationFlow()
    }
}
