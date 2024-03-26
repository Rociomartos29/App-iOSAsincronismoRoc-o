//
//  TransformUseCase.swift
//  DragonBall
//
//  Created by Rocio Martos on 21/3/24.
//

import Foundation
import Combine
protocol TransformationsUseCaseProtocol {
    var repo: TransformationsRepositoryProtocol { get set }
    func getTransformations(forHeroWithID id: UUID) async throws -> [Transformation]
}

// Implementación real del caso de uso
final class TransformationsUseCase: TransformationsUseCaseProtocol {
    var repo: TransformationsRepositoryProtocol
    
    init(repo: TransformationsRepositoryProtocol = TransformationsRepository()) {
        self.repo = repo
    }
    
    func getTransformations(forHeroWithID id: UUID) async throws -> [Transformation] {
        return try await repo.getTransformations(forHeroWithID: id)
    }
}

// Implementación falsa del caso de uso (para pruebas)
final class TransformationsUseCaseFake: TransformationsUseCaseProtocol {
    var repo: TransformationsRepositoryProtocol
    
    init(repo: TransformationsRepositoryProtocol = TransformationsRepositoryFake()) {
        self.repo = repo
    }
    
    func getTransformations(forHeroWithID id: UUID) async throws -> [Transformation] {
        return try await repo.getTransformations(forHeroWithID: id)
    }
}

