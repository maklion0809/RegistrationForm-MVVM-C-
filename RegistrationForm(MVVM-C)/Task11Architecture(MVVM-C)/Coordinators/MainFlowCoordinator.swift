//
//  MainFlowCoordinator.swift
//  Task11Architecture(MVVM-C)
//
//  Created by Tymofii (Work) on 26.10.2021.
//

import UIKit

protocol MainCoordinatorDelegate: AnyObject {
    func userInitiatedSignOut()
    func userInitiatedDetailed(object: String)
}

protocol MainFlowCoordinatorDelegate: AnyObject {
    func userFinishedMainFlow()
}

final class MainFlowCoordinator: Coordinator, MainCoordinatorDelegate {
    weak var delegate: MainFlowCoordinatorDelegate?
    private let navigationController = UINavigationController()
    private let window: UIWindow
    
    init(window: UIWindow) {
        self.window = window
    }
    
    func start() {
        window.rootViewController = navigationController
        let controller = MainViewController()
        let viewModel = MainViewModel()
        viewModel.delegate = self
        controller.viewModel = viewModel
        navigationController.pushViewController(controller, animated: true)
    }
    
    // MARK: - MainCoordinator
    
    func userInitiatedSignOut() {
        delegate?.userFinishedMainFlow()
    }
    
    func userInitiatedDetailed(object: String) {
        let controller = DetailedViewController()
        let viewModel = DetailedViewModel(model: DetailedModel(object: object))
        controller.viewModel = viewModel
        navigationController.pushViewController(controller, animated: true)
    }
}
