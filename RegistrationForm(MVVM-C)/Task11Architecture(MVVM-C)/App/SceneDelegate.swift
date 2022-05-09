//
//  SceneDelegate.swift
//  Task11Architecture(MVVM-C)
//
//  Created by Tymofii (Work) on 25.10.2021.
//

import UIKit

class SceneDelegate: UIResponder, UIWindowSceneDelegate {

    private var applicationFlowCoordinator: ApplicationFlowCoordinator?

    func scene(_ scene: UIScene, willConnectTo session: UISceneSession, options connectionOptions: UIScene.ConnectionOptions) {
        guard let windowScene = (scene as? UIWindowScene) else { return }
        
        let window = UIWindow(windowScene: windowScene)
        applicationFlowCoordinator = ApplicationFlowCoordinator.init(window: window)
        applicationFlowCoordinator?.start()
        
        window.makeKeyAndVisible()
    }
}

