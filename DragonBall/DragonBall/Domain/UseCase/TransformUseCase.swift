//
//  TransformUseCase.swift
//  DragonBall
//
//  Created by Rocio Martos on 21/3/24.
//

import Foundation

protocol TransformationsUseCaseProtocol {
    var repo: TransformationsRepositoryProtocol { get set }
    func getTransformations(filter: UUID?) async -> [Transformacione]
}

// Caso Real
final class TransformationsUseCase: TransformationsUseCaseProtocol {
    func getTransformations(filter: UUID?) async -> [Transformacione] {
        await repo.getTransformation(filter: filter)
    }
    
    var repo: TransformationsRepositoryProtocol
    
    init(repo: TransformationsRepositoryProtocol = TransformationsRepository(network: NetworkTransformations())) {
        self.repo = repo
    }
}

// Fake
final class TransformationsUseCaseFake: TransformationsUseCaseProtocol {
    var repo: TransformationsRepositoryProtocol
    
    init(repo: TransformationsRepositoryProtocol = TransformationsRepository(network: NetworkTransformations())) {
        self.repo = repo
    }

    func getTransformations(filter: UUID?) async -> [Transformacione] {
        await repo.getTransformation(filter: filter)
    }
}
