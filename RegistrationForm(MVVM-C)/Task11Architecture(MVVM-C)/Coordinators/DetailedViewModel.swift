//
//  DetailedViewModel.swift
//  Task11Architecture(MVVM-C)
//
//  Created by Tymofii (Work) on 26.10.2021.
//

import Foundation

protocol DetailedViewModelInterface {
    func object() -> String
}

final class DetailedViewModel: DetailedViewModelInterface {
    
    // MARK: - Variable
    
    private let model: DetailedModel

    // MARK: - Initialization
    
    init(model: DetailedModel) {
        self.model = model
    }
    
    // MARK: - DetailedViewModelInterface
    
    func object() -> String {
        model.object
    }
}
