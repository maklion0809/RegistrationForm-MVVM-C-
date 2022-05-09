//
//  ApplicationFlowCoordinator.swift
//  Task11Architecture(MVVM-C)
//
//  Created by Tymofii (Work) on 25.10.2021.
//

import UIKit

final class ApplicationFlowCoordinator: Coordinator {
    private let window: UIWindow
    private let storage: UserSession = .shared

    init(window: UIWindow) {
        self.window = window
    }
    
    func start() {
        if storage.wasUserLoggedIn == nil {
            startActivationFlow()
        } else {
            startMainFlow()
        }
    }
    
    private func startActivationFlow() {
        let activationFlowCoordinator = ActivationFlowCoordinator(window: window)
        activationFlowCoordinator.delegate = self
        activationFlowCoordinator.start()
    }
    
    private func startMainFlow() {
        let mainFlowCoordinator = MainFlowCoordinator(window: window)
        mainFlowCoordinator.delegate = self
        mainFlowCoordinator.start()
    }
}

extension ApplicationFlowCoordinator: ActivationFlowCoordinatorDelegate {
    func userFinishedActivationFlow() {
        startMainFlow()
    }
}

extension ApplicationFlowCoordinator: MainFlowCoordinatorDelegate {
    func userFinishedMainFlow() {
        startActivationFlow()
    }
}
