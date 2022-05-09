//
//  MainViewModel.swift
//  Task11Architecture(MVVM-C)
//
//  Created by Tymofii (Work) on 26.10.2021.
//

import Foundation

protocol MainViewModelInterface {
    var numberOfRows: Int { get }
    func getObject(at indexPath: IndexPath) -> String?
    func addString(string: String)

    func handleSignOutButton()
    func handleDetailedAction(at indexPath: IndexPath)
}

final class MainViewModel: MainViewModelInterface {
    
    // MARK: - Variable

    var delegate: MainCoordinatorDelegate?
    private var model: MainModel
    private let storage: UserSession = .shared

    // MARK: - Initialization
    
    init(model: MainModel = .init()) {
        self.model = model
    }
    
    // MARK: - MainViewModelInterface
    
    var numberOfRows: Int {
        model.strings.count
    }
    
    func getObject(at indexPath: IndexPath) -> String? {
        model.strings[indexPath.item]
    }
    
    func addString(string: String) {
        model.strings.append(string)
    }

    func handleSignOutButton() {
        storage.cleanActiveSession()
        delegate?.userInitiatedSignOut()
    }
    
    func handleDetailedAction(at indexPath: IndexPath) {
        let object = model.strings[indexPath.item]
        delegate?.userInitiatedDetailed(object: object)
    }
}
